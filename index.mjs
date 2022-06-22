import pg from 'pg'
import express from 'express'
import bcrypt from 'bcrypt'
import JWT from 'jsonwebtoken'
import dotenv from 'dotenv'
import { promisify } from 'util'
import bodyParser from 'body-parser'

const { Pool } = pg

// Loading variables from the .env file
dotenv.config()

const isProduction = process.env.NODE_ENV === "production";

const connectionString = `postgresql://${process.env.PG_USER}:${process.env.PG_PASSWORD}@${process.env.PG_HOST}:${process.env.PG_PORT}/${process.env.PG_DATABASE}`;

const pool = new Pool(
  {
    connectionString: isProduction ? process.env.DATABASE_URL : connectionString,
    ssl: {
        rejectUnauthorized: false,
    },
  }
)
await pool.connect()

export default pool;

// Launching express
const app = express()

// Promisify the JWT helpers
// => transform callback into Promise based function (async)
const sign = promisify(JWT.sign)
const verify = promisify(JWT.verify)

// Use the json middleware to parse the request body
app.use(express.json())


app.use(bodyParser.urlencoded({ extended: true }));

app.post('/api/register', async (req, res) => {
  const { email, nickname, password } = req.body

  if (!email || !password || !nickname)
    return res.status(400).send({ error: 'Invalid request' })

  try {
    const encryptedPassword = await bcrypt.hash(password, 10)

    await pool.query(
      'INSERT INTO users (email, password, nickname) VALUES ($1, $2, $3)',
      [email, encryptedPassword, nickname]
    )

    return res.send({ info: 'User succesfully created' })
  } catch (err) {
    console.log(err)

    return res.status(500).send({ error: 'Internal server error' })
  }
})

app.post('/api/login', async (req, res) => {
  const { email, password } = req.body

  if (!email || !password)
    return res.status(400).send({ error: 'Invalid request' })

  const q = await pool.query(
    'SELECT password, id, nickname from users WHERE email=$1',
    [email]
  )

  if (q.rowCount === 0) {
    return res.status(404).send({ error: 'This user does not exist' })
  }

  const result = q.rows[0]
  const match = await bcrypt.compare(password, result.password)

  if (!match) {
    return res.status(403).send({ error: 'Wrong password' })
  }

  try {
    const token = await sign(
      { id: result.id, nickname: result.nickname, email },
      process.env.JWT_SECRET,
      {
        algorithm: 'HS512',
        expiresIn: '15000h',
      }
    )

    return res.send({ token })
  } catch (err) {
    console.log(err)
    return res.status(500).send({ error: 'Cannot generate token' })
  }
})

app.get('/', (req, res) => {
  res.send({ info: 'Hello '})
})

// This middleware will ensure that all subsequent routes include a valid token in the authorization header
// The 'user' variable will be added to the request object, to be used in the following request listeners
app.use(async (req, res, next) => {
  if (!req.headers.authorization) return res.status(401).send('Unauthorized')

  try {
    const decoded = await verify(
      req.headers.authorization.split(' ')[1],
      process.env.JWT_SECRET
    )

    if (decoded !== undefined) {
      req.user = decoded
      return next()
    }
  } catch (err) {
    console.log(err)
  }

  return res.status(403).send('Invalid token')
})

app.get('/api/hello', (req, res) => {
  res.send({ info: 'Hello ' + req.user.nickname + ' !'})
})

app.get('/api/users', async (req, res) => {
  const q = await pool.query('SELECT nickname from users')
  return res.send(q.rows)
})

app.get('/api/users/:user_id', async (req, res) => {
  const {user_id} = req.params
  const q = await pool.query('SELECT nickname from users WHERE id = $1',[user_id])
  if (q.rowCount === 0) {
    return res.status(404).send({ error: 'This user does not exist' })
  }
  return res.send(q.rows)

})

app.get('/api/lobby', async (req, res) => {
  const q = await pool.query('SELECT name from public.lobby')
  return res.send(q.rows)
})


app.get('/api/lobby/:lobby_id', async (req, res) => {
  const {lobby_id} = req.params
  const q = await pool.query('SELECT * from public.lobby WHERE id = $1',[lobby_id])
  if (q.rowCount === 0) {
    return res.status(404).send({ error: 'This lobby does not exist' })
  }
  return res.send(q.rows)
})

app.get('/api/lobby/:lobby_id/messages', async (req, res) => {
  const {lobby_id} = req.params
  const q = await pool.query('SELECT text from public.messages WHERE lobby_id = $1',[lobby_id])
  if (q.rowCount === 0) {
    return res.status(404).send({ error: 'This lobby has no message' })
  }
  return res.send(q.rows)
  
})

app.get('/api/lobby/:lobby_id/messages/:message_id', async (req, res) => {
  const {lobby_id} = req.params
  const {message_id} = req.params
  const q = await pool.query('SELECT text from public.messages WHERE lobby_id = $1 AND id = $2',[lobby_id, message_id])
  if (q.rowCount === 0) {
    return res.status(404).send({ error: 'This message does not exist' })
  }
  return res.send(q.rows)
  
})

app.post('/api/lobby/', async (req, res) =>{
  const admin = req.user.id
  const {lobby_name} = req.body
  const q = await pool.query('INSERT INTO public.lobby (name, admin_id) VALUES ($1, $2)',[lobby_name, admin])

  if (!lobby_name) {
    return res.status(400).send({ error: 'Invalid name' })
  }

  else {
  return res.send({ info: 'New lobby created'})
  }
})


app.post('/api/lobby/:lobby_id', async (req, res) => {

  try {
    const {text, lobby_id, user_id} = req.body
  
    const participants = await pool.query('SELECT user_id FROM public.users_in_lobby WHERE user_id=$1 AND lobby_id=$2',[user_id,lobby_id])
    if(participants.rowCount===0){
      res.send('not authorized')
      console.log(participants.rows);}

    if (!text) {
        return res.status(400).send({ error: 'Invalid message' })
    }

    else {
      const q = await pool.query(
        'INSERT INTO public.messages (text, author_id, lobby_id, created, edited) VALUES ($1, $2, $3, now(), now());',
        [text, user_id, lobby_id])  
      return res.send({ info: 'Text succesfully sent' + q.rows[0] })
    } 
   }

  catch (err) {
    console.log(err)
    return res.status(500).send({ error: 'Internal server error' })
  }
  })

  app.post('/api/lobby/:lobby_id/add-user', async (req, res) => {
    const {user_id} = req.body
    const {lobby_id} = req.params
    
      try {

        await pool.query(
          'INSERT INTO public.users_in_lobby (lobby_id, user_id) VALUES ($1, $2)',
          [lobby_id, user_id]
        )
    
        return res.send({ info: 'User succesfully added to lobby' })
      } catch (err) {
        console.log(err)
    
        return res.status(500).send({ error: 'Internal server error' })
      }
  })

  app.patch('/api/lobby/:lobby_id/', async (req, res) => {
    const {lobby_id} = req.params
    const {message_id} = req.body
    const {text} = req.body
    const addedDate = new Date();
    const edited = addedDate.toISOString();
    const userEdit = req.user.id
    const q = await pool.query('SELECT id, author_id from public.messages WHERE lobby_id=$1 AND id=$2',[lobby_id, message_id])
    if (q.rowCount === 0) {
      return res.status(404).send({ error: 'This message does not exist' })
    }
    if(q.rows[0].author_id != userEdit) {
      return res.status(400).send({ error: 'Invalid user' })
    }
    else {
      if (!text){
        return res.status(400).send({ error: 'Invalid message' })
      }
      else {
        await pool.query(
            'UPDATE public.messages SET text=$1, edited=$2 WHERE id=$3',
            [text, edited, message_id])
      }

      return res.send("Message has been edited !")
    }
  })

  app.delete('/api/lobby/:lobby_id/remove-user', async (req, res) => {
    const {user_id} = req.body
    const {lobby_id} = req.params
    const user = req.user.id

    const isUserInLobby = await pool.query('SELECT user_id FROM public.users_in_lobby WHERE lobby_id=$1 AND user_id=$2)',[lobby_id, user_id])
    if(isUserInLobby.rowCount===0){
      res.send('user does not exist in lobby')}
    
    else {

      const isUserAdmin = await pool.query('SELECT admin_id FROM public.lobby WHERE id=$1 AND admin_id=$2',[lobby_id, user])
      if (isUserAdmin.rowCount === 0) {
        return res.status(404).send({ error: 'User is not admin' })
      }
      else {
        try {

          await pool.query(
            'DELETE FROM public.users_in_lobby WHERE lobby_id=$1 AND user_id=$2',
            [lobby_id, user_id]
          )
      
          return res.send({ info: 'User succesfully deleted from lobby' })
        } catch (err) {
          console.log(err)
      
          return res.status(500).send({ error: 'Internal server error' })
        }
      }
    } 
  })

  app.delete('/api/lobby/', async (req, res) => {

    const {lobby_id} = req.body
    const admin = req.user.id

    const lobbyToDelete = await pool.query('SELECT id, admin_id FROM public.lobby WHERE id=$1',[lobby_id])
    if(lobbyToDelete.rowCount===0){
      res.send('Lobby does not exist')}
      console.log(admin)
      console.log(lobbyToDelete.rows[0])
    if(lobbyToDelete.rows[0].admin_id != admin) {
      return res.status(400).send({ error: 'User is not admin' })
    }
    
    else {
    
      try {

        await pool.query(
          'DELETE FROM public.lobby WHERE id=$1 AND admin_id=$2',
          [lobby_id, admin]
        )
    
        return res.send({ info: 'Lobby succesfully deleted' })
      } catch (err) {
        console.log(err)
    
        return res.status(500).send({ error: 'Internal server error' })
      }
    } 
  })


app.listen(process.env.PORT || 3002, () => console.log('http://localhost:3002'))
