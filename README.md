# Wordie

Welcome to Wordie, a notes app built with flutter.

## Getting Started

The first step to testing or running this app is getting the code

    git clone https://github.com/maroafenogho/wordie.git
    .
    .
    *flutter pub get*

## App Features
The app uses the riverpod folder structure:

    lib/src/features/📁data
                           /📁services/note_service.dart
                           /📁repository/note_repo.dart
                    /📁domain/note_model.dart
                    /📁presentation/📁screens/note_screen.dart
                                   /📁controllers/note_controller.dart

Each <strong>service.dart</strong> file contains code to query Firebase or carry out authentication calls. The data retrieved fron the network call is parsed to the <strong>repo.dart</strong> class.The controller class receives the data from the repo and in turn determines what the user sees.

### User Authentication
<img src="./sign_up_screen.jpg">
When you run the app for the first time, you will be directed to the login page. As a new user, you would have to navigate to the sign-up page by tapping on the signup botton. 
User registration is achieved by using the createUserWithEmailAndPassword() method from firebase. When a user is successfully registered, the entered name is used to update the user's display name and a verification email is sent while the app navigates to the Login screen. The login logic prevents users who have not verified their email addresses from gaining access.
