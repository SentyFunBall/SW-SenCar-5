# SenCar 5 Documentation
Hi. This is the place where I write how the fuck everything inside of SenCar 5 works, both for you reading this, and me in the future. This includes my thought process on almost everything, code examples, and why things are what they are. Well. Good luck. Yes, I'm pretty sure this is one of the only micros in the game to require documentation. Fuck me.

## Contents
1. [How does it work?](#how-does-sencar-5-work)
2. [More Links](#more-links)
3. [Main dash](#main-dash)
    1. [Themes](#themes)
4. [Widget Display](#widget-display)
    1. [WidgetAPI](#widgetapi)
5. [Radio Display](#radio-display)
6. [Center Display](#center-display)
    1. [AppAPI](#appapi)

## How does SenCar 5 work?
In short, SenCar 5 works just like every other microcontroller in Stormworks: logic. The numbers feed into the ever-growing microcontroller (mc), and feed into the LUA blocks (or somewhere else), and then runs through the code seen in this repository. 

## More Links
- [Code Examples](examples.md)
- [Custom Functions](functions.md)
- [API Downloads](apis/downloads.md)

## Main Dash
The dashboard is inspired off of Apple CarPlay. The map is rendered first, assuming that the car is not in reverse. The side gradients (`for` loop), large cirles, empty dials and dials are then rendered on top. All the circles are rendered using a custom circle function, which allows me to draw arcs, and rings. Stormworks pixels are not entirely square on some screens, such as the 3x1, because of the extra width compared to height. This causes the perfect circles from the function to be slighly oblong in game. We combated this by dealing with it.

### Themes
The 7 different themes for SenCar 5 are stored in a table, shared across the 4 Lua scripts. At the beginning on `onDraw()`, I store the color values in a table called `_`. In the code whenever I change colors, I dynmically get the color based on the theme. Example:

    _colors = {
        {{47,51,78}, {86,67,143}, {128,95,164}}, --sencar 5 in the micro
        {{17, 15, 107}, {22, 121, 196}, {48, 208, 217}} --blue
    }
    
    function onTick() --runs 60 times/second
        info.properties.theme = property.getNumber("Theme") --gets the current theme. number 1-7
    end
    
    function onDraw() --runs 60 times/second for every screen connected
        local _ = _colors[info.properties.theme]
        
        c(_[1][1], _[1][2], _[1][3]) --you better understand tables.
        drawCircle(16, 16, 12, 0, 21, 0, math.pi*2) --uses our custom circle function to draw circles.
    end
        

## Widget Display

### WidgetAPI
[WidgetAPI Full Documentation](/docs/apis/widgetapi.md)

## Music Display

## Center Display

### AppAPI
[AppAPI Full Documentation](/docs/apis/appapi.md)
