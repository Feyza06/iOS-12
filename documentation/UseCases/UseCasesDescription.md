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
