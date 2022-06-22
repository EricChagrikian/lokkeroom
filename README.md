# Lokkeroom

#### **In the context of a training task for BeCode,**
I had to make an API that would only return JSON and on which users could: 

**- Register and login and encrypt registered passwords,**

**- Create a message lobby for which the creator would be the admin of,**

**- Be added or removed from a lobby, aswell as to be a member of multiple lobbies,**

**- To view and send messages from the lobby they are added to,**

**- To edit and delete their own messages, with the admin being allowed to delete other users messages.**

All of it has been deployed on Heroku with the link: https://lokkeroomeric.herokuapp.com/

There is no HTML to register or login, so I'd recommend using Insomnia, Postman, or anything similar to visit the API, as a Token is required to access most of the routes.

### List of routes


 Route  | Method | Bearer token? | Usage 
 ------ | -------| -------------| -----
 / | GET | None | Simply says Hello 
 /api/register  | POST | None | Register a new user 
 /api/login | POST | None | Login as existing user 
 /api/hello | GET | Yes | Says Hello + user's nickname 
 /api/users | GET | Yes | List of all users 
 /api/users/:user_id | GET | Yes | To get the id of a single user 
 /api/lobby | GET | Yes | List of all lobbies 
 /api/lobby/:lobby_id | GET | Yes | To show the name of a single lobby 
 /api/lobby/:lobby_id/messages | GET | Yes | To show the messages inside a lobby
 /api/lobby/:lobby_id/messages/:message_id | GET | Yes | To show a single message inside a lobby
 /api/lobby/:lobby_id | POST | Yes | To send a message in a lobby
 /api/lobby/:lobby_id/add-user | POST | Yes | To add an user to a lobby 
 /api/lobby/:lobby_id/ | PATCH | Yes | To edit an existing message in a lobby 
 /api/lobby/:lobby_id/remove-user | DELETE | Yes | To remove an user from a lobby 
 /api/lobby | DELETE | Yes | To delete a lobby 
 
 
 ### List of forms
 
 
**-Form to register:**
 {
 "email": "your@email.example",
  "nickname": "YourName",
  "password": "Your password"
 }
 
 
 **-Form to login:** 
 {
 "email": "your@email.example",
  "password": "Your password"
 }

 
 
 **-Form to POST a message:** 
 {
  "text": "I like cats",
  "user_id": <The ID of your User [Example: "user_id": 55]>
 }
 
 
 **-Form for /add-user:**
 {
  "user_id": <ID of the User you want to add [Example: "user_id": 55]>
 }
 
 **-Form to PATCH a message:** 
 {
  "message_id": <ID of the message to edit [Example: "message_id": 498]]>,
  "text": "This is the Edited text"
 }
 
 **-Form for /remove-user [only for admin of lobby]:**
 {
  "user_id": <ID of the User you want to remove [Example: "user_id": 55]>
 }
 
 
