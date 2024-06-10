# RECIPE-APP-FLUTTER-WITH-ADMIN-PANEL
<div align="center">

  ### <img src="https://avatars.githubusercontent.com/u/76232843?s=400&u=52234351df87372dea43a90243320f9e6a78e70c&v=4" height="100px"/> 

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
        <th style="text-align:center">
            <a href="#">
                <img src="https://cdn.svgporn.com/logos/google-gmail.svg" width="30">
            </a>
        </th>
    </tr>
</table>
<br>

## Requirements

### FIRST
```
  Create new flutter project
```

### Install Firebasetools
``` 
  npm install -g firebase-tools
```
### Login Firebase in your VS Code
``` 
  firebase login
```

## Enable Google Map SDK for each platform.
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

## Screenshot

<img src="https://github.com/Frave07/Flutter-Delivery-App/blob/main/screenshot/Delivery-Food-Brinning.png" />

---

## DBAD license

```sh
  # DON'T BE A DICK PUBLIC LICENSE

  > Version 1.0, June 2024

  > Copyright (C) [2024] [Mqiu Developers]

  Everyone is permitted to copy and distribute verbatim or modified
  copies of this license document.

  > DON'T BE A DICK PUBLIC LICENSE
  > TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  1. Do whatever you like with the original work, just don't be a dick.

     Being a dick includes - but is not limited to - the following instances:

   1a. Outright copyright infringement - Don't just copy this and change the name.
   1b. Selling the unmodified original with no work done what-so-ever, that's REALLY being a dick.
   1c. Modifying the original work to contain hidden harmful content. That would make you a PROPER dick.

  2. If you become rich through modifications, related works/services, or supporting the original work,
  share the love. Only a dick would make loads off this work and not buy the original work's
  creator(s) a pint.

  3. Code is provided with no warranty. Using somebody else's code and bitching when it goes wrong makes
  you a DONKEY dick. Fix the problem yourself. A non-dick would submit the fix back.
```

