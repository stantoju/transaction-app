# Transaction App

This is an assessment code result put together by Stanley Okegbe

# Stack

The following Technology stack was used in this project :

Technology : **Swift (UIKit)**

IDE : **XCode**

Architechture : **MVVM (Clean Architecture)**

Testing : **Unit Tests, Integrated Tests**

UI State Management : **Combine**

Navigation and Dependency Injections : **Coordinator Layout**

# How to To Run

**1** - Clone the Repository (https://github.com/stantoju/transaction-app.git)

**2** - Unzip the the project zip file

**3** - Launch the TransactionApp.xcodeproj file

# Technical Decisions and Actions

**1** USING PROGRAMATIC UI

- Reasons :
  -- From experience, I believe programatic UI's help create flexibe and re-usable view as against storyboards
- Actions: The implementation of the ApiController
  -- Transition from storyboard to Programatic UI
- Solution
  -- Deleted Main.storyboard
  -- Create the UI's Programatically

**2** DELETION ITEMS

- Scenario :
  -- Delete transaction items from core data with interactions from the view
- Challenges :
  -- It would have been ideal to have the user interact and delete the transaction item directly from the TransactionController
  -- The process of rendering the transcation from did make that pretty easy (Another approach was taken)
- Actions:
  -- I took the approach of passing the list of transactions for a particular day to another view controller (DeletionController)
  -- I also took the opportunity to showcase the navigation and dependency injection through the implemented coordinator pattern
- Result
  -- Seemless item deletion implementaion and user experience

**3** USING CLEAN ARCHITECTURE

- Reasons :
  -- I needed to be able to test every entity independently, with flexible dependency injection
- Actions:
  -- Structure the app properly to adhere to the MVVM Clean Architecture Pattern

# Commit History

-- Git Commit Histories were chronological made along with the development process

# Architecture

<img src="https://user-images.githubusercontent.com/39156499/188281391-c7159d19-c48c-4862-aa34-142dfcb9c8bf.jpg" width="700px">

# Screenshots

<img src="https://user-images.githubusercontent.com/39156499/188281448-9a4cb7c1-c00e-4c17-bb08-29f697a885a0.png" width="250px">
<img src="https://user-images.githubusercontent.com/39156499/188281447-93629883-3d59-4845-a1f1-1724a8e4ba7c.png" width="250px">
<img src="https://user-images.githubusercontent.com/39156499/188281446-fd7d81b2-7f21-4f25-9922-12b6a9cd9c9a.png" width="250px">
<img src="https://user-images.githubusercontent.com/39156499/188281441-de07b072-521b-412c-99c6-c8d0ab17fba4.png" width="250px">
