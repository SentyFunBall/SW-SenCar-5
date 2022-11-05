# SenCar 5 Documentation
Hi. This is the place where I write how the fuck everything inside of SenCar 5 works, both for you reading this, and me in the future. This includes my thought process on almost everything, code examples, and why things are what they are. Well. Good luck. Yes, I'm pretty sure this is one of the only micros in the game to require documentation. Fuck me.

Updated for commit 65, or SenCar v5.0.dev.65

## Contents
1. [How does it work?](#how-does-sencar-5-work)
2. [More Links](#more-links)
3. [Main dash](#main-dash)
    1. [Themes](#themes)
4. [Widget Display](#widget-display)
    1. [WidgetAPI](#widgetapi)
5. [Music Display](#music-display)
6. [Center Display](#center-display)
7. [How it's made](#how-its-made)

## How does SenCar 5 work?
In short, SenCar 5 works just like every other microcontroller in Stormworks: logic. The numbers feed into the ever-growing microcontroller (mc), and feed into the LUA blocks (or somewhere else), and then runs through the code seen in this repository. 

## More Links
- [Code Examples](examples.md)
- [Custom Functions](functions.md)
- [API Downloads](apis/downloads.md)

## Main Dash
The dashboard is inspired off of Apple CarPlay. The map is rendered first, assuming that the car is not in reverse. The side gradients (`for` loop), large cirles, empty dials and dials are then rendered on top. All the circles are rendered using a custom circle function, which allows me to draw arcs, and rings. Stormworks pixels are not entirely square on some screens, such as the 3x1, because of the extra width compared to height. This causes the perfect circles from the function to be slighly oblong in game. We combated this by dealing with it.

The icons on the dash are handled by another script, since the main script is increasingly large. I'll offload the warning icons to the secondary dash script in commit #67. Turns out that the day I was making the icons, [MrLennyns Drawing Canvas](https://mrlennyn.github.io/canvas/canvas.html) was acting up, same with the LifeBoatAPI simulator, and made me have to make all the icons by hand. So I did that, and used lots of boolean logic. While making the general warning indicator, I somehow used 400 chars? Reduced that down shortly after. The "Doors open display" as I call it, the popup that shows when door(s) is open, was also a pain in the ass because the simualtor floors the params for `screen.drawLine()`. This made it so all the lines were 1 pixel too short.

All of the big UI elements are translucent, including the doors open display, all widgets, the music display, the dash circles and more popups are all translucent. The dials for speed and RPM were a big tricky. I made the circles, and then with the *same function*, I drew the darkened "basin" that the dial sits in. Then with the same function one more, duplicated the line of code but in a different color so it looks better.

![image](https://user-images.githubusercontent.com/57205125/187019717-f21d9e66-12d0-448b-90fc-7bc0b3ef6249.png)
![image](https://user-images.githubusercontent.com/57205125/187019722-6952eac1-3263-4adc-8368-cae9a77a2c1c.png)

### Themes
The 7 different themes for SenCar 5 are stored in a table, shared across the 4 main Lua scripts. At the beginning on `onDraw()`, I store the color values in a table called `_`. In the code whenever I change colors, I dynmically get the color based on the theme. Example:

```lua
_colors = {
    {{47,51,78}, {86,67,143}, {128,95,164}}, --sencar 5 in the micro
    {{17, 15, 107}, {22, 121, 196}, {48, 208, 217}} --blue
}

function onTick() --runs 60 times/second
    theme = property.getNumber("Theme") --gets the current theme. number 1-7
    -- ignore that theme is a number in the actual OS, this is for simplicity
end

function onDraw() --runs 60 times/second for every screen connected
    local _ = _colors[theme] --if theme is 1, then _ is {{47,51,78}, {86,67,143}, {128,95,164}}

    c(_[1][1], _[1][2], _[1][3]) --_[1] is {47, 51, 78}, so _[1][1] is 47.
    screen.drawRectF(5, 5, 10, 10)
end
```
    
Themes change the whole experience. With AppAPI and WidgetAPI, developers can also adjust the colors of their apps and widgets to the current theme.
Default SenCar 5 theme:
![image](https://user-images.githubusercontent.com/57205125/187018624-b7826a4c-e38d-4b55-b428-5b9506dc8047.png)

Blue theme:
![image](https://user-images.githubusercontent.com/57205125/187018558-60614feb-bdf4-4d36-b2bf-ea7e09e3c354.png)
*Images taken 8/26/22, SenCar v5.0.dev.65*
        
## Widget Display
The widget display is just a gradient, based on the theme, with the widgets on top. The widgets are drawn by WidgetAPI (I was going to call it WidgetKit because thats what it is but that was taken by Apple). Widgets are pretty simple. You define the table, and call `WidgetAPI.draw()`. That's it. I'm honestly surprised how simple I got it for how complex it is. What should be 12 lines of code, are shortened into 2. Damn. 

We import WidgetAPI, the theme table and we're off to the races. Define as many widgets as you want, although only 3 can be drawn. I guess you could use 1 to draw all 3, but I havent tested. Up to three widgets can be drawn, and only 2 if one is large. In `onTick()`, we want to collect any data for our widget (battery, time, weather, etc), and change any values in the widgets here, for multiplayer and performance reasons. In `onDraw()`, we draw the background, and the widgets. Damn simple, and I love it.

### WidgetAPI
[WidgetAPI Full Documentation](/docs/apis/widgetapi.md)

## Music Display
The music display is the simplest of all 4 displays, ngl. I was thinking of lying and saying "Oh yeah the music display was made in WidgetAPI", but it wasn't. It was indeed hardcoded, and acts like a simple display, but colored and written to *look* nice. I think thats half of making a UI based Lua program, making it look good. Doesn't matter whats under the hood, as long as it looks good to the user. Guess thats half of this program. Anyway. The music display acts like any other lua script with a bit of text and touch input, so yeah.

It also subtly changes color while "music" (input from the radio) is detected. It automatically adjusts the colors based on the theme. The signal bars are probably the most complex part of it, since the arrows are just buggy touch boxes (yup not even formed correctly), and the channel text is just a number. The signal strength is also pretty simple. "If the strength is less than 0.9, draw 3 filled bars and 1 empty bar." "If the strength is less than 0.7, then draw 2 empty bars and 2 filled ones." 

## Center Display
Not made as of v5.0.dev.65

## How its made
SenCar 5 was made with 3 things: Blood, Sweat, and Tears. Unless?
SenCar 5 was made with 3 things: LifeBoatAPI/VSCode, Stormworks, and Trapdoor's LuaInject.

The code was written in VSCode for rapid-fire-testing, simulated and minimized using LifeBoatAPI, and injected into the Stormworks test bench automatically via a Python module and Stormworks Addon.
