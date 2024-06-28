# plantist_project

Flutter To Do List project with sign in and sign up 

## About Project 

TODOs must be grouped day by day and sorted according to the priority of
each TODO.
● Utilize Firebase for user authentication, Firestore for data storage, and Storage
for attachment uploads.
● State Management: Use GetX. Do not use SetState.
● User Authentication: Implement user sign-in and sign-up functionality using
Firebase Authentication.
● TODO Management: Utilize Firebase Firestore to store and retrieve user TODOs.
A TODO must have the following properties: “title, note, priority, due date,
category, tags.”

-Screens
Sign-in and Sign-up Screens: Design and implement screens for user
authentication. Users should be able to sign in or sign up using Firebase
Authentication.
● TODO List Screen: Create a screen to display the list of user TODOs. Implement
functionalities to view, edit, and delete TODOs. TODOs must be sorted by
priority.
● Create New TODO Screen: Develop a screen for users to create a new TODO.
Include input fields for the title, note, priority, due date, category, tags, and an
optional attachment.

-Extras 
Attachment Feature: Implement the optional property for a TODO, allowing
users to attach a photo or file. Uploaded attachments should be stored in
Firebase Storage.
● Local Notifications: Set up local notifications to remind users of upcoming
TODOs. Notifications should be sent one day and five minutes before the due
date.
● Biometric Authentication: Implement a method channel for biometric
authentication. Users should have the option to authenticate using biometrics.
● Search Functionality: Implement a search feature to allow users to search and
filter their TODOs based on different criteria.
