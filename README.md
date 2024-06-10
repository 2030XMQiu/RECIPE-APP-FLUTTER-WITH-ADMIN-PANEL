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

### Create FIrebase Project
``` 
  Open https://firebase.google.com/
  Login with ur account
  Go to console -> add new project
  
```

### Install Firebasetools
``` 
  Lib/Services/url.dart
```

## Enable Google Map SDK for each platform.
- Go to [Google Developers Console](https://console.cloud.google.com)
- To enable Google Maps for Android and iOS.
- Page API KEY -> lib/Services/GoogleServices
- Page API KEY -> Android/app/src/main/AndroidManifest.xml

## MAPBOX API KEY
- Go to [Mapbox](https://www.mapbox.com/)
- Page API KEY -> lib/Controller/MapBoxController

## PUSH NOTIFICATIONS - Cloud Messaging | Firebase
- Page Server Key => lib/Services/PushNotification.dart
- Page google-services.json => Android/App/
- Go Firebase
- Project settings
- Cloud Messaging
- Server key

## Flutter
- Flutter Bloc 
- Socket io client
- Google Map
- MapBox
- Geolocator
- Push notifications

# Backend [NodeJs]
- [Backend - Javascript](https://github.com/Frave07/Backend-Delivery-App-Flutter)


---

## Screenshot

<img src="https://github.com/Frave07/Flutter-Delivery-App/blob/main/screenshot/Delivery-Food-Brinning.png" />

---

## DBAD license

```sh
  # DON'T BE A DICK PUBLIC LICENSE

  > Version 1.1, December 2016

  > Copyright (C) [2023] [frave developer]

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

