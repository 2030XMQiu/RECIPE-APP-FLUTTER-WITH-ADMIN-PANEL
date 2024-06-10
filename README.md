# RECIPE-APP-FLUTTER-WITH-ADMIN-PANEL
<div align="center">

  ### <img src="https://avatars.githubusercontent.com/u/76401666?s=400&u=53e72048830573e02e46e62b6fb1123b2ac59562&v=4" height="100px"/> 

  ***2030XMqiu***
</div>

<div align="center">
   Recipe App
</div>


<br>
<table align="center">
    <tr>
<!--         <th style="text-align:center">
            <a href="https://cutt.ly/pckBg9D">
                <img src="https://cdn.svgporn.com/logos/youtube-icon.svg" width="40">
            </a>
        </th> -->
        <th style="text-align:center">
            <a href="https://www.instagram.com/knantaufik">
                <img src="https://github.com/aritraroy/social-icons/blob/master/instagram-icon.png?raw=true" width="40">
            </a>
        </th>
<!--         <th style="text-align:center">
            <a href="#">
                <img src="https://cdn.svgporn.com/logos/google-gmail.svg" width="30">
            </a>
        </th> -->
    </tr>
</table>
<br>

## Requirements

### FIRST
```
  Create new flutter project
```
### Edit pubspec.yaml
```
  dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
  get: ^4.6.6
  curved_navigation_bar: ^1.0.4
  cloud_firestore: ^4.17.5
  firebase_core: ^2.32.0
  firebase_auth: ^4.20.0
  flutter_easyloading: ^3.0.5
  random_string: ^2.3.1
  shared_preferences: ^2.2.3
  image_picker: ^1.1.2
  firebase_storage: ^11.7.7
  http: ^1.2.1
  awesome_dialog: ^3.2.1
```
```
  assets:
    - images/
```

### Install Flutter Package
```
flutter pub get
```

### Install Firebasetools
``` 
  npm install -g firebase-tools
```

### Login Firebase in your VS Code
``` 
  firebase login
```

## Setting Firebase Console
- Go to [Firebase Console](https://firebase.google.com)
- Add new Project
- Creat Authenthication -> Email/Password
- Create Firestore Database -> set rules ->  allow read, write: if true;
- Create Firestore Storage -> set rules ->  allow read, write: if true;

### Add Firebase Project to Flutter
``` 
  flutter pub global activate flutterfire_cli
```
``` 
  flutterfire configure
```
- Select your Firebase Project

### Run Your Flutter Project
``` 
  flutter run
```
## Admin Panel Or User
- Go to lib/main.dart
- For Admin Panel -> home: AdminLogin()
- For User -> home: AuthGate()

## Screenshot

<img src="https://github.com/2030XMQiu/RECIPE-APP-FLUTTER-WITH-ADMIN-PANEL/blob/main/Screenshot/Screenshot_20240610-230901.jpg" height="100" />
<img src="https://github.com/2030XMQiu/RECIPE-APP-FLUTTER-WITH-ADMIN-PANEL/blob/main/Screenshot/Screenshot_20240610-232055.jpg" height="100" />

---

## DBAD license

```sh
  > Version 1.0, June 2024

  > Copyright (C) [2024] [Mqiu Developers]

  Everyone is permitted to copy and distribute verbatim or modified
  copies of this license document.

```

