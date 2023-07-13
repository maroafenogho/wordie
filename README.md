# Wordie

Welcome to Wordie, a notes app built with flutter.

## Getting Started

The first step to testing or running this app is getting the code

    git clone https://github.com/maroafenogho/wordie.git
    .
    .
    flutter pub get

Run the app to confirm that everything works
    
    flutter run

## App Features

The app uses the Riverpod Architechture as proposed by Andrea together with the feature first approach. The folder structure for the project is:

    lib/src/features/📁data
                           /📁repository/note_repo.dart
                    /📁application
                           /📁services/note_service.dart
                    /📁domain
                          /note_model.dart
                    /📁presentation
                         /📁screens/note_screen.dart
                         /📁controllers/note_controller.dart

<a href="https://pub.dev/packages/flutter_riverpod">Riverpod</a> is used for state management, <a href="https://pub.dev/packages/go_router">go_router</a> for navigation, firebase for authentication and realtime database.

Each <strong>/📁data/repo.dart</strong> file contains code to query Firebase or carry out authentication calls. The data retrieved fron the network call is parsed to the <strong>/📁application/service.dart</strong> class. The controller class receives the data from the service class and uses the data to update state.

### User Authentication
<img src="./sign_up_screen.jpg">

When you run the app for the first time, you will be directed to the login page. As a new user, you would have to navigate to the sign-up page by tapping on the signup botton. 
User registration is achieved by using the *createUserWithEmailAndPassword()* method from firebase. When a user is successfully registered, the entered name is used to update the user's display name and a verification email is sent while the app navigates to the Login screen. The login logic prevents users who have not verified their email addresses from gaining access.

<img src="./login_screen.jpg">

 <img src="./empty_dash.jpg">
 <img src="./empty_favs.jpg">
 <img src="./dash_list.jpg">
 <img src="./dash_grid.jpg">
 <img src="./add_.jpg">
 <img src="./favs.jpg">
 <img src="./del.jpg">

# What you can learn from this repo
1. Riverpod state management and dependency overrides
2. go_router
3. Custom widgets
4. Firebase authentication
5. Firebase database
6. Feature-first Architecture
7. Shared preferences
8. Dart extension and more