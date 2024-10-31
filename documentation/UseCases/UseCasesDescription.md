# Per Owner 

## Create an Account 


#### Use Template for your use case description: 

| **Name:**                     |                     |
|-------------------------------|---------------------|
| **Actor:**                    |                     |
| **Description:**              |                     |
| **Pre-condition:**            |                     |
| **Scenario:**                 |                     |
|                               | 1.                  |
|                               | 2.                  |
|                               | 3.                  |
| **Result:**                   |                     |  
| **Extension:**                |                     |    
| **Exception:**                |                     | 

| **Name:**                     | Create an account                                                           |
|-------------------------------|-----------------------------------------------------------------------------|
| **Actor:**                    | Pet Owner & Pet Adopter                                                     |
| **Decription:**               | Actor creates an accout for themselves.                                     |
| **Pre-condition:**            | Actor is on the registration page.                                          |
| **Scenario:**                 |                                                                             |
|                               | 1. Actor navigates to the registration page.                                |
|                               | 2. The system displays the registration form.                               |
|                               | 3. Actor enters required information such as name, email, password.         |
|                               | 4. Actor clicks the submit button.                                          |
|                               | 5. The system validates the information and confirms the account creation.  |
| **Result:**                   | Account is created successfully.                                            |  
| **Extension:**                |  3a. If email is already registered, the system prompts the Actor to enter a different email.|                   |    
| **Exception:**                |   4a. If any information is invalid (e.g. weak password, missing fields), system displays an error message and requests corrections.                  |  


| **Name:**                     | Log in              |
|-------------------------------|---------------------|
| **Actor:**                    | Pet Owner & Pet Adopter |
| **Decription:**               | Actor logs into their account. |
| **Pre-condition:**            | Actor has a registered account and is on the log in page.|
| **Scenario:**                 |                     |
|                               | 1. Actor navigates to the login page.                 |
|                               | 2. System displays the log in form.                 |
|                               | 3. Actor enters their registered email and password.  |
|                               | 4. Actor submits the log in form.  |
|                               | 5. The system verifies the credentials. |
|                               | 6. The system grants access and redirects Actor to home page.  |
| **Result:**                   |  Actor is logged in successfully.                   |  
| **Extension:**                |  None.                 |    
| **Exception:**                |  4a. If credentials are invalid, system disoplays error message and prompts re-entry.  | 

| **Name:**                     | Log out             |
|-------------------------------|---------------------|
| **Actor:**                    | Pet Owner & Pet Adopter |
| **Decription:**               | Actor logs out of their account. |
| **Pre-condition:**            | Actor is currently logged into their account.|
| **Scenario:**                 |                     |
|                               | 1. Actor clicks on "Log out" button.             |
|                               | 2. System terminates the current session and logs out user.|
|                               | 3. System redirects user to home page. |
| **Result:**                   |  Actor is logged out successfully.      |  
| **Extension:**                |  None.                 |    
| **Exception:**                | None.  | 

| **Name:**                     | Upload Post               |
|-------------------------------|---------------------|
| **Actor:**                    |  Pet Owner                   |
| **Description:**              |  Pet Owner creates a posts for his pet.                   |
| **Pre-condition:**            |  Actor is logged into their account. |
| **Scenario:**                 |                     |
|                               | 1. Actor clicks the upload post button. |
|                               | 2. System promts the Actor to choose an image.   |
|                               | 3. Actor uploads desired photo of his pet.  |
|                               | 4. Systems displays field to enter a description of his pet. |
|                               | 5. Actor enters a description of the pet, including name, age, breed, and personality traits. |
|                               | 6. System displays field to specify the preferred home for the pet (e.g. houshold type, presence of other pets, activity level.  |
|                               | 7. Actor clicks on submit buttom.  |
|                               | 8. System validates the content and uploads post to the feed. |
| **Result:**                   | Actor has successfully uploaded a post.                    |  
| **Extension:**                |                     |    
| **Exception:**                |                     | 

| **Name:**          | Receive Notifications                                                                  |
|--------------------|----------------------------------------------------------------------------------------|
| **Actor:**         | Pet Owner                                                                              |
| **Description:**   | Pet Owner receives notification for interaction with pet post or private message.      |
| **Pre-condition:** | Actor has account and is logged in and created pet post.                               |
| **Scenario:**      |                                                                                        |
|                    | 1. A profile interacts with Actor's Post (Like, Comment?) or receives private message. |
|                    | 2. System notices new interaction and sends fitting notification through app or email. |
|                    | 3. Actor receives notification.                                                        |
| **Result:**        | Actor sees Notification.                                                               |  
| **Extension:**     | 3a. Actor has notifications disabled.                                                  |    
| **Exception:**     | 2a. Notification fails to send due to connection issue. System retries to send.        | 



| **Name:**                     | search for matching pets|
|-------------------------------|---------------------|
| **Actor:**                    |  Adopter                   |
| **Decription:**               |    1.  As an adopter, I want to be able to search for pets so that I can find a pet that matches my preferences.                 |
| **Pre-condition:**            |     be logged in and have an account                |
| **Scenario:**                 |                     |
|                               | 1.   User selects his preferences               |
|                               | 2.  matching pets pop up and the user can select which one he prefers                 |
|                               | 3.  User can mark pet as favorite or can message the owner instant                 |
| **Result:**                   |     Adopter finds matching pet                 |  
| **Extension:**                |                     |    
| **Exception:**                |                     |    



| **Name:**                     | filter my search                |
|-------------------------------|----------------------------------|
| **Actor:**                    | Adopter                          |
| **Description:**              | The adopter wants to filter search results by distance, pet type, and breed to find the best matches. |
| **Pre-condition:**            | The adopter is on the search page, and filter options for distance, pet type, and breed are available. |
| **Scenario:**                 |                                  |
|                               | 1. The adopter opens the search page. |
|                               | 2. The adopter selects filter options for distance, pet type, and breed. |
|                               | 3. The search results update according to the selected filters. |
| **Result:**                   | The adopter sees a filtered list of available pets that match the chosen criteria. |
| **Extension:**                | The adopter can apply additional filters or adjust current filters to further narrow down the results. |
| **Exception:**                | If no pets match the filter criteria, a message appears stating that no matches were found. |



| **Name:**                     | remove Pet from favorites        |
|-------------------------------|----------------------------------|
| **Actor:**                    | Adopter                          |
| **Description:**              | The adopter wants to delete pets from their favorites list to manage their preferred selections. |
| **Pre-condition:**            | The adopter has a list of favorite pets and is on the favorites page. |
| **Scenario:**                 |                                  |
|                               | 1. The adopter navigates to their favorites list. |
|                               | 2. The adopter selects a pet they want to remove. |
|                               | 3. The pet is removed from the favorites list. |
| **Result:**                   | The adopter’s favorites list updates, showing only the remaining pets. |
| **Extension:**                | The adopter can undo the removal if they change their mind immediately after. |
| **Exception:**                | If the pet cannot be removed due to an error, an error message is displayed. |

