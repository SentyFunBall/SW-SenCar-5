--centraldisplay
-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Workshop: 

--Code by STCorp. Do not reuse.--
--- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--- If you have any issues, please report them here: https://github.com/nameouschangey/STORMWORKS_VSCodeExtension/issues - by Nameous Changey


--[====[ HOTKEYS ]====]
-- Press F6 to simulate this file
-- Press F7 to build the project, copy the output from /_build/out/ into the game to use
-- Remember to set your Author name etc. in the settings: CTRL+COMMA


--[====[ EDITABLE SIMULATOR CONFIG - *automatically removed from the F7 build output ]====]
---@section __LB_SIMULATOR_ONLY__
do
    ---@type Simulator -- Set properties and screen sizes here - will run once when the script is loaded
    simulator = simulator
    simulator:setScreen(1, "3x2")
    simulator:setProperty("Theme", 1)
    simulator:setProperty("Units", true)
    simulator:setProperty("FONT1", "00019209B400AAAA793CA54A555690015244449415500BA0004903800009254956D4592EC54EC51C53A4F31C5354E52455545594104110490A201C7008A04504")
    simulator:setProperty("FONT2", "FFFE57DAD75C7246D6DCF34EF3487256B7DAE92E64D4975A924EBEDAF6DAF6DED74856B2D75A711CE924B6D4B6A4B6FAB55AB524E54ED24C911264965400000E")

    -- Runs every tick just before onTick; allows you to simulate the inputs changing
    ---@param simulator Simulator Use simulator:<function>() to set inputs etc.
    ---@param ticks     number Number of ticks since simulator started
    function onLBSimulatorTick(simulator, ticks)

        -- touchscreen defaults
        local screenConnection = simulator:getTouchScreen(1)
        simulator:setInputBool(2, screenConnection.isTouched)
        simulator:setInputNumber(1, screenConnection.touchX)
        simulator:setInputNumber(2, screenConnection.touchY)

        simulator:setInputBool(1, true)
        simulator:setInputNumber(3, simulator:getSlider(1))
        simulator:setInputNumber(4, 0)
    end;
end
---@endsection


--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!
require("LifeBoatAPI")

_colors = {
    {{47,51,78}, {86,67,143}, {128,95,164}}, --sencar 5 in the micro
    {{17, 15, 107}, {22, 121, 196}, {48, 208, 217}}, --blue
    {{74, 27, 99}, {124, 42, 161}, {182, 29, 224}} --purple
}

home = false
pulse = false
press = false
app = 0

function onTick()
    acc = input.getBool(1)
    theme = property.getNumber("Theme")

    press = input.getBool(2)

    touchX = input.getNumber(1)
    touchY = input.getNumber(2)

    x = input.getNumber(4)
    y = input.getNumber(5)
    compass = input.getNumber(6)*(math.pi*2)

    clock = input.getNumber(3)
    if property.getBool("Units") then --
        clock = string.format("%02d",math.floor(clock*24)%12)..":"..string.format("%02d",math.floor((clock*1440)%60))
        if string.sub(clock, 1, 2) == "00" then
            clock = "12"..string.sub(clock, 3,-1)
        end
    else
        clock = string.format("%02d",math.floor(clock*24))..":"..string.format("%02d",math.floor((clock*1440)%60))
    end

    home =  isPointInRectangle(touchX, touchY, 0, 7, 15, 7)

    if isPointInRectangle(touchX, touchY, 36, 0, 13, 14) then
        app = 1 --map
    end
    if isPointInRectangle(touchX, touchY, 51, 0, 13, 14) then
        app = 2 --info
    end

    if home then app = 0 end

    output.setNumber(3, app)
end

function onDraw()
    local _ = _colors[theme]
    if acc then
        if app == 0 then
            for x = 1, 32 do
                for y = 0, 21 do
                    c(
                        getBilinearValue(_[1][1], _[2][1], _[1][1], _[3][1], x/32, y/21),
                        getBilinearValue(_[1][2], _[2][2], _[1][2], _[3][2], x/32, y/21),
                        getBilinearValue(_[1][3], _[2][3], _[1][3], _[3][3], x/32, y/21)
                    )
                    screen.drawRectF(x*3-3, y*3-0, 3,3)
                end
            end

            --background
            screen.setColor(15,2,30)
            screen.drawRectF(27,11,41,41)
            screen.drawRectF(28,10,39,1)
            screen.drawRectF(26,12,1,39)
            screen.drawRectF(28,52,39,1)
            screen.drawRectF(68,12,1,39)
            screen.setColor(21,18,107)
            screen.drawRectF(41,19,12,3)
            screen.drawRectF(41,22,3,8)
            screen.drawRectF(44,27,6,3)
            screen.drawRectF(50,30,3,8)
            screen.drawRectF(41,38,9,3)
            screen.setColor(1,0,2)
            screen.drawRectF(43,41,3,1)
            screen.drawRectF(40,41,3,2)
            screen.drawRectF(37,43,3,1)
            screen.drawRectF(34,44,3,1)
            screen.drawRectF(31,45,3,1)
            screen.drawRectF(28,46,3,1)
            screen.drawRectF(26,47,2,1)
            screen.drawRectF(38,19,3,1)
            screen.drawRectF(35,20,3,1)
            screen.drawRectF(32,21,3,1)
            screen.drawRectF(29,22,3,1)
            screen.drawRectF(26,23,3,1)
            screen.drawRectF(37,20,4,23)
            screen.drawRectF(32,21,5,23)
            screen.drawRectF(27,23,5,23)
            screen.drawRectF(32,44,2,1)
            screen.drawRectF(26,24,2,23)
            screen.drawRectF(41,30,9,8)
        end

        c(_[1][1], _[1][2], _[1][3], 250)
        screen.drawRectF(0, 0, 96, 15)

        --draw dock
        c(200, 200, 200)
        dst(1, 1, clock, 1)

        --apps
        -- weather app
        screen.setColor(33,117,255)
        screen.drawRectF(23,2,10,11)
        screen.drawLine(24,1,32,1)
        screen.drawLine(33,3,33,12)
        screen.drawLine(24,13,32,13)
        screen.drawLine(22,3,22,12)
        screen.setColor(226,168,16)
        screen.drawRectF(24,2,2,4)
        screen.drawRectF(23,3,4,2)
        screen.setColor(255,255,255)
        screen.drawRectF(26,7,6,3)
        screen.drawRectF(27,6,5,1)
        screen.drawRectF(28,5,3,1)
        screen.drawRectF(32,7,1,3)
        screen.drawRectF(25,8,1,2)

        -- maps
        screen.setColor(255,255,255)
        screen.drawRectF(43,1,1,4)
        screen.drawRectF(44,5,5,1)
        screen.drawRectF(44,11,5,1)
        screen.drawRectF(43,12,1,2)
        screen.setColor(195,181,150)
        screen.drawRectF(36,6,7,6)
        screen.drawRectF(38,12,5,2)
        screen.drawRectF(37,12,1,1)
        screen.drawRectF(44,12,4,1)
        screen.drawRectF(44,13,3,1)
        screen.drawRectF(44,6,5,5)
        screen.setColor(40,139,20)
        screen.drawRectF(37,2,6,3)
        screen.drawRectF(44,2,4,3)
        screen.drawRectF(48,3,1,2)
        screen.drawRectF(44,1,3,1)
        screen.drawRectF(38,1,5,1)
        screen.drawRectF(36,3,1,2)
        screen.setColor(3,124,239)
        screen.drawRectF(36,5,8,1)
        screen.drawRectF(43,6,1,5)
        screen.setColor(3,55,239)
        screen.drawRectF(43,11,1,1)
        screen.setColor(250,183,15)
        screen.drawLine(36,7,42,12)
        screen.drawLine(44,13,45,13)

        -- sencar 5
        screen.setColor(14,2,26)
        screen.drawRectF(52,2,11,11)
        screen.drawRectF(53,1,9,1)
        screen.drawRectF(63,3,1,9)
        screen.drawRectF(53,13,9,1)
        screen.drawRectF(51,3,1,9)
        screen.setColor(21,19,103)
        screen.drawRectF(56,3,3,2)
        screen.drawRectF(56,6,3,6)
        screen.setColor(1,0,2)
        screen.drawRectF(54,3,2,1)
        screen.drawRectF(52,4,2,1)
        screen.drawRectF(51,5,1,1)
        screen.drawRectF(56,12,2,1)
        screen.drawRectF(54,13,2,1)
        screen.drawRectF(54,6,2,1)
        screen.drawRectF(52,7,2,1)
        screen.drawRectF(54,4,2,1)
        screen.drawRectF(51,8,1,1)
        screen.drawRectF(52,5,2,1)
        screen.drawRectF(51,6,1,1)
        screen.drawRectF(54,7,2,6)
        screen.drawRectF(52,8,2,5)
        screen.drawRectF(53,13,1,1)
        screen.drawRectF(51,9,1,3)


        -- info
        screen.setColor(_[2][1], _[2][2], _[2][3])
        screen.drawRectF(67,2,11,11)
        screen.drawRectF(68,1,9,1)
        screen.drawRectF(78,3,1,9)
        screen.drawRectF(68,13,9,1)
        screen.drawRectF(66,3,1,9)
        screen.setColor(0,0,0)
        screen.drawRectF(70,2,5,3)
        screen.drawRectF(70,5,1,7)
        screen.drawRectF(74,5,1,7)
        screen.drawRectF(71,7,3,2)
        screen.drawRectF(71,10,3,2)
        screen.drawRectF(69,5,1,1)
        screen.drawRectF(68,6,1,1)
        screen.drawRectF(75,5,1,1)
        screen.drawRectF(76,6,1,1)
        screen.drawRectF(75,8,1,1)
        screen.drawRectF(76,9,1,1)
        screen.drawRectF(69,8,1,1)
        screen.drawRectF(68,9,1,1)

        --control center button
        c(100, 100, 100)
        screen.drawLine(81, 2, 81, 13)
        c(150, 150, 150)
        drawRoundedRect(84, 1, 10, 12)
        c(200,200,200)
        drawToggle(85, 3, false)
        drawToggle(85, 8, true)


        --home button
        drawRoundedRect(1, 7, 16, 6)
        c(100, 100, 100)
        dst(2, 8, "Home", 1)
    end
end

function c(...) local _={...}
    for i,v in pairs(_) do
     _[i]=_[i]^2.2/255^2.2*_[i]
    end
    screen.setColor(table.unpack(_))
end

function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function drawPointer(x,y,c,s)
    local d = 5
    local sin, pi, cos = math.sin, math.pi, math.cos
    screen.drawTriangleF(sin(c - pi) * s + x + 1, cos(c - pi) * s + y +1, sin(c - pi/d) * s + x +1, cos(c - pi/d) * s + y +1, sin(c + pi/d) * s + x +1, cos(c + pi/d) * s + y +1)
end

function interpolate(x,y,alpha) --simple linear interpolation
	local difference=y-x
	local progress=alpha*difference
	local result=progress+x
	return result
end

function getBilinearValue(value00,value10,value01,value11,xProgress,yProgress)
	local top=interpolate(value00,value10,xProgress) --get progress across line A
	local bottom=interpolate(value01,value11,yProgress) --get line B progress
	local middle=interpolate(top,bottom,yProgress) --get progress of line going
	return middle                              --between point A and point B
end

function drawRoundedRect(x, y, w, h)
    screen.drawRectF(x+1, y+1, w-1, h-1) --body
    screen.drawLine(x+2, y, x+w-1, y) --top
    screen.drawLine(x, y+2, x, y+h-1) --left
    screen.drawLine(x+w, y+2, x+w, y+h-1) --right
    screen.drawLine(x+2, y+h, x+w-1, y+h) --bottom
end

function drawToggle(x,y,state)
    if state then
        c(100,200,100)
        screen.drawLine(x+1, y, x+7, y)
        screen.drawLine(x, y+1, x+6, y+1)
        screen.drawLine(x+1, y+2, x+7, y+2)
        c(200,200,200)
        screen.drawLine(x+7, y, x+7, y+3)
        screen.drawLine(x+6, y+1, x+9, y+1)
    else
        c(100,100,100)
        screen.drawLine(x+2, y, x+8, y)
        screen.drawLine(x+3, y+1, x+9, y+1)
        screen.drawLine(x+2, y+2, x+8, y+2)
        c(200,200,200)
        screen.drawLine(x+1, y, x+1, y+3)
        screen.drawLine(x, y+1, x+3, y+1)
    end
end

--dst(x,y,text,size=1,rotation=1,is_monospace=false)
--rotation can be between 1 and 4
f=screen.drawRectF
g=property.getText
--magic willy font
h=g("FONT1")..g("FONT2")
i={}j=0
for k in h:gmatch("....")do i[j+1]=tonumber(k,16)j=j+1 end
function dst(l,m,n,b,o,p)b=b or 1
o=o or 1
if o>2 then n=n:reverse()end
n=n:upper()for q in n:gmatch(".")do
r=q:byte()-31 if 0<r and r<=j then
for s=1,15 do
if o>2 then t=2^s else t=2^(16-s)end
if i[r]&t==t then
u,v=((s-1)%3)*b,((s-1)//3)*b
if o%2==1 then f(l+u,m+v,b,b)else f(l+5-v,m+u,b,b)end
end
end
if i[r]&1==1 and not p then
s=2*b
else
s=4*b
end
if o%2==1 then l=l+s else m=m+s end
end
end
end