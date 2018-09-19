# Who You Know

## Application Description
* Tech Stack: React frontend and Rails API backend.

* Application Purpose: Allows a user to better learn the connections in their LinkedIn network.  

* How It Works: After authenticating with LinkedIn OAuth, the user's connections are retrieved from LinkedIn. The user must first sort each connection into 3 categories(easy, medium, hard) based on how well they can identify the connection from  profile photo.  The user can then play a set of connections to practice identifying connections from their LinkedIn profile photos. Scores for each play and information about incorrect answers are recorded and displayed to the user when the play is completed.  Historical score information for each difficulty level is also available to the user.

## Initial Setup

1. Clone the repository

 ```shell
 git clone git@github.com:justinetroyke/who-you-know-backend.git
 ```
2. Navigate to the `who-you-know-backend` directory

 ```shell
 cd who-you-know-backend
 ```

3. Install the dependencies

 ```shell
 bundle install
 ```

3. Set up the database

 ```shell
 rake db:setup
 ```

4. Run test suite

 ```shell
   rspec
 ```
<hr>

## Running the Server Locally

To see your code in action locally, you need to fire up a development server. Use the command:

 ```shell
 rails s
 ```

Once the server is running, visit API endpoints in your browser:

* `http://localhost:3000/` to run your application.

<hr>

## Deployments
* Back end is deployed here with Heroku: https://who-you-know.herokuapp.com/

* To see the [React frontend app](https://github.com/tdberg21/who-you-know-FE) deployed with Heroku, visit https://who-you-know-fe.herokuapp.com/

<hr>

## API Endpoints

**Create User**
---
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Returns newly created user's id to be used in future api requests.

* **URL**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/api/v1/users?api_key={LinkedIn Access Token}&id_token={LinkedIn User Id Token}

* **Method:**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`POST`

* **Success Response:**

 * **Code:** 201 CREATED <br />
   **Content Example:**

   `{ "id": 35 }`

* **Error Response:**

 * **Code:** 400 BAD REQUEST <br />

<hr>

**Retrieve Unsorted Connections**
---
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;Returns 30 unsorted connections.

* **URL**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/api/v1/users/{user_id}/cards

* **Method:**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`GET`

* **Success Response:**

 * **Code:** 200 OK<br />
   **Content Example:**
   ```
    [
      {
        "id"=>1,
        "first_last_name"=>"Gandalf",
        "company"=>"Hobbits United",
        "school"=>"Hogwarts",
        "job_title"=>"Badass Wizard",
        "image_url"=>"https://images.unsplash.com/photo-1529259646408-5c50deb4cf6a?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=b0dfd63ba103ae5ca31b1ddf0d85822f&dpr=1&auto=format&fit=crop&w=1000&q=80&cs=tinysrgb",
        "profile_url"=>"https://www.linkedin.com/in/gandalf-the-great/"
      },
      {
        "id"=>2,
        "first_last_name"=>"Ricky Bobby",
        "company"=>"Inappropriate Inc",
        "school"=>"Hard Knocks",
        "job_title"=>"Super Cool Dude",
        "image_url"=>"https://images.unsplash.com/photo-1529259646408-5c50deb4cf6a?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=b0dfd63ba103ae5ca31b1ddf0d85822f&dpr=1&auto=format&fit=crop&w=1000&q=80&cs=tinysrgb",
        "profile_url"=>"https://www.linkedin.com/in/ricky-bobby/"
      }
    ]
    ```

* **Error Response:**

 * **Code:** 400 BAD REQUEST <br />

<hr>

**Assign Difficulty Level to Connection**
---
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Update's a card's difficulty level.

* **URL**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/api/v1/users/{user_id}/cards/{card_id}?difficulty={difficulty_level}

* **Method:**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`PUT`

* **Success Response:**

 * **Code:** 200 OK <br />

* **Error Response:**

 * **Code:** 400 BAD REQUEST <br />

<hr>

**Retrieve Connections with Difficulty Level**
---
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Returns 12 connections: 8 within the given difficulty level and 2 in each of the other two difficulty levels.

* **URL**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/api/v1/users/{user_id}/cards?difficulty={difficulty_level}

* **Method:**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`GET`

* **Success Response:**

 * **Code:** 200 OK <br />
   **Content Example:**
   ```
    [
      {
        "id"=>1,
        "first_last_name"=>"Gandalf",
        "company"=>"Hobbits United",
        "school"=>"Hogwarts",
        "job_title"=>"Badass Wizard",
        "image_url"=>"https://images.unsplash.com/photo-1529259646408-5c50deb4cf6a?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=b0dfd63ba103ae5ca31b1ddf0d85822f&dpr=1&auto=format&fit=crop&w=1000&q=80&cs=tinysrgb",
        "profile_url"=>"https://www.linkedin.com/in/gandalf-the-great/"
      },
      {
        "id"=>2,
        "first_last_name"=>"Ricky Bobby",
        "company"=>"Inappropriate Inc",
        "school"=>"Hard Knocks",
        "job_title"=>"Super Cool Dude",
        "image_url"=>"https://images.unsplash.com/photo-1529259646408-5c50deb4cf6a?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=b0dfd63ba103ae5ca31b1ddf0d85822f&dpr=1&auto=format&fit=crop&w=1000&q=80&cs=tinysrgb",
        "profile_url"=>"https://www.linkedin.com/in/ricky-bobby/"
      }
    ]
    ```

* **Error Response:**

 * **Code:** 400 BAD REQUEST <br />

<hr>

**Record Score**
---
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Records a score after playing a set of connections.

* **URL**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/api/v1/users/{user_id}/scores?difficulty={level}&num_played={num}&num_correct={num}

* **Method:**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`POST`

* **Success Response:**

 * **Code:** 201 CREATED <br />

* **Error Response:**

 * **Code:** 400 BAD REQUEST <br />

<hr>

**Retrieve Score**
---
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Returns total percentages correct in each difficulty category.

* **URL**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/api/v1/users/{user_id}/scores

* **Method:**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`GET`

* **Success Response:**

 * **Code:** 200 OK <br />
   **Content Example:**
   `{"easy"=>"70.0%", "medium"=>"50.0%", "hard"=>"30.0%"}`
