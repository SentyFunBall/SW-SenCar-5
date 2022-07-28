# SenCar 5
[Developer Documentation](docs/docs.md)

SenCar 5 is the greatest new evolution of the SenTOS Car OS line of operating systems. SenTOS Car was built for the original 2nd gen Echolodia (Echolodia 2021), and has been continually evolving ever since. However, the looks of the operating system has stayed mostly the same, with no major overhaul in the last 2 years. This is where it changes.
SenTOS Car 4 was our largest update to date, adding tons of quality of life features that let us focus on UI overhauls. Now called SenCar, This latest evolution changes everything you were used too. Not sorry.

## Contents
1. [All new UI](#all-new-ui)
    1. [Themes](#themes)
    2. [Dashboard](#dashboard)
    3. [Widget Display](#widget-display)
    4. [Radio Display](#radio-display)
    5. [Central Display](#central-display)
2. [Everything New](#everything-new)
3. [For Developers](#for-developers)
    1. [Included APIs](#included-apis)
    2. [Libs and APIs used](#libraries-and-apis-used)
    3. [Credits](#credits)

## All New UI
SenCar 5 features a brand new UI, made from scratch, with as little compromises as possible. There are 4 new screens, 2 are optional, for a full new experience of using SenCar 5, and any car it is in. SenCar 5 is designed to take over nearly every element of a car, and the 4 new screens let you control them perfectly. Built on top of the powerful SenOS architecture, it is easier than ever to control a car now. 

### Themes
SenCar 5 features 7 themes to customize your experience with the car to the max. Custom currated colors match each theme perfectly, so that they dont contrast eachother. 

### Dashboard
The dashboard has been redesigned from the ground up. 2 large speed and RPM dials occupy the screen with a map (with SenConnect 1.1 and later support). Fuel and temperture dials outline the edges of the large dials. Of course, the colors of the dashboard align with those in the current theme, giving a gorgeous look everywhere you are. 

### Widget Display
The widget display is a brand new addition to SenCar 5, and it allows you to view detailed information at a glance, such as the weather, a phone, trip stats, and more. Plus, SenCar 5 comes with an easy way to add your own Widgets via [WidgetAPI](docs/apis/widgetapi.md). The widget display is optional. The colors of each widget, and the gradient background, change with the theme.

SenCar 5 can change what widgets are displayed up and front, depending on what is most important. A huge storm might be a little more important than the fact that it's lunchtime. Up to 3 widgets can be displayed at once, giving you tons of information to be able to see at a glance.

### Radio Display
The radio display lets you see current information about the radio, such as whats playing, talk back with Push-To-Talk (PTT), or connect with third-party music options to play music.

### Central Display
The central display is where all the fun stuff happens. Climate, Weather, Settings, Maps, Control Center, and much more are all availble with the central display. The display works in an app-like fashion, with apps made with [AppAPI](docs/apis/appapi.md). Settings lets you change everything about the car, from its theme, units, view its name and version, and much more. Control Center has all the stuff you want to access quickly, like the door lock, hazards, and privacy information. <sup>(SentyTek does not collect any information from SenCar 5, or any of the vehicles it is featured in.)</sup> Maps has all the latest SenConnect info, waypoints, and directions in the future. And so on. Climate has all the heating things, weather has detailed weather reports. <sup> (Only if you have the PAW Weather Tower addon enabled. Subject to change, check here for updates.)</sup> The central display has all the necessities to make a car functional.

## Everything New

### Drive Modes

### Back up camera

### SenConnect

### Automatic this and that

### Tow Mode

### Enhanced Transmission

### So much more

## For Developers
We have included a full documentation of the entire system [here](/docs/docs.md). Enjoy!
Below are the included APIs, the ones we used, and our inspiration

### Included APIs
[WidgetAPI](/docs/apis/widgetapi.md)

[AppAPI](/docs/apis/appapi.md)

### Libraries and APIs used
 - [LifeBoatAPI](https://marketplace.visualstudio.com/items?itemName=NameousChangey.lifeboatapi)
 - [Lua 5.2 w/ Stormworks](https://www.lua.org/manual/5.2/)

### Inspiration
UI is heavily inspired off of next generation [Apple Carplay](https://www.wired.com/story/apple-carplay-dashboard-touchscreen-distracted-driving/).

UI is partially inspired off of Phil's car dashboard and map they posted one time in the Stormworks Discord server.

### Credits
Programming and design - SentyFunBall

Programming and design - MerianBerry

Documentation writer - SentyFunBall

Marketing - SentyFunBall

Testing - So many people, of which I thank you all dearly.
