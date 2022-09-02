# Transaction App

This is an assessment code result put together by Stanley Okegbe

# Stack

The following Technology stack was used in this project :

Technology : **Swift (UIKit)**

IDE : **XCode**

Architechture : **MVVM (Clean Architecture)**

Testing : **Unit Tests, Integrated Tests**

UI State Management : **Combine**


# How to To Run

**1** - Clone the Repository (https://github.com/stantoju/transaction-app.git)

**2** - Unzip the  the project zip file

**3** - From the root folder, run "pod install" on a terminal

**4** - Launch the LeagueMobileChallenge.xcworkspace file


# Thought Processes

**SITUATION** 

    - Having gone through the challenge requirement, I got to see that the "Post" api response does not carry the "User" property, but a userId property instead. And the User list can be gotten from an additional api request

**TASK** 

    -  I got to understand that for each displayed item on the tableview, there would be a need to map the user.id for every post.userId, so as to have an object with the complete properties of Avatar image, Username, Title and Description
    
**ACTION** 

    - With the help of GCD, I made concurrent API requests to both the Users Api and Post Api, and with a DispatchGroup notify when both tasks are completed, then take the following actions...
        - If any of the request returns error, call the error closure
        - If both request return successfully with data, map the recieved post data and user data, matching post.userId to user.id to create a new domain objects of Posts (under the domain folder), then call the success clocure
    
**RESULT** 

    - The result is an mapped array of [Post] which is passed upward and acheived in the fastest possible timing. This is explained in the next point
    - Why conmcurrent request to both endpoints and not serial
        -- Serial would have equally worked just fine, but with concurrent requests, we get to save the app user a few split seconds if not more.


# Technical Decisions and Actions

**1** REMOVAL OF ALAMOFIRE AND PRE-EXISTING API-CONTROLLER CLASS
- Reasons : 
    -- I wasnt too comfortable with the pre-existing Api Controller used with the AlamoFire Library. I believe the code wasnt properly implemented and inflexible. It also has a tendency to grow out of control as the project features increase.
    -- I noticed forced-cast into/from "Any?" was used, which should be a last resort and avoided however possible
    -- I try to use Libraries, only when I have to. In this case, I believe I can effectively setup a simple network layer without having to use AlamoFire
    
- Actions: 
    -- Deleted the APiController File
    -- Removed AlamoFire Library
    
- Solution
    -- Created a generic network layer that can conform to any kind of network response
    
    
**2** USING PROGRAMATIC UI
- Reasons : 
    -- From experience, I believe programatic UI's help create flexibe and re-usable view as against storyboards
    
- Actions: The implementation of the ApiController
    -- Transition from storyboard to Programatic UI
    
- Solution
    -- Deleted Main.storyboard
    -- Create the UI's Programatically
    
    
**3** USING CLEAN ARCHITECTURE
- Reasons : 
    -- I needed to be able to test every entity independently, with flexible dependency injection
    
- Actions: 
    -- Structure the app properly to adhere to the MVVM Clean Architecture Pattern
    
- Solution
    -- Created and tested PostRepository
    -- Created and tested PostUsecase
    -- Created and tested PostViewmodel

# Commit History

-- Git Commit Histories were chronological made along with the development process
