--appmap
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
    simulator:setProperty("Car name", "Solstice")

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
        simulator:setInputNumber(4, 0)

        simulator:setInputNumber(3, math.floor(simulator:getSlider(1)*4))
    end;
end
---@endsection


--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!
require("LifeBoatAPI")

SENCAR_VERSION = "5.0.dev"
SENCAR_VERSION_BUILD = "10082314b"

_colors = {
    {{47,51,78}, {86,67,143}, {128,95,164}}, --sencar 5 in the micro
    {{17, 15, 107}, {22, 121, 196}, {48, 208, 217}}, --blue
    {{74, 27, 99}, {124, 42, 161}, {182, 29, 224}} --purple
}

zoom = 3
scrollPixels = 0
mx, my = 0,0
wx, wy = 0,0
debug = false

function onTick()
    acc = input.getBool(1)
    theme = property.getNumber("Theme")

    touchX = input.getNumber(1)
    touchY = input.getNumber(2)

    press = input.getBool(3) and press + 1 or 0
    app = input.getNumber(3)

    x = input.getNumber(4)
    y = input.getNumber(5)
    compass = input.getNumber(6)*(math.pi*2)

    carname = property.getText("Car name")

    if app == 1 then --maps
        if press > 0 and isPointInRectangle(touchX, touchY, 0, 18, 12, 12) then zoom = clamp(zoom - 0.01 - press/800, 0.3, 25) end
        if press > 0 and isPointInRectangle(touchX, touchY, 0, 30, 12, 12) then zoom = clamp(zoom + 0.01 + press/800, 0.3, 25) end
        if press > 0 and isPointInRectangle(touchX, touchY, 0, 42, 12, 12) then zoom = 3 mx,my = 0,0 end
        if press == 2 and isPointInRectangle(touchX, touchY, 0, 52, 12, 12) then if wx == 0 then wx,wy = ax,ay else wx,wy = 0,0 end end
        output.setNumber(1, wx)
    end

    if app == 2 then --info
        if press > 0 and isPointInRectangle(touchX, touchY, 0, 18, 12, 19) then --up
            scrollPixels = clamp(scrollPixels-1, 0, 10000) --honestly, the max value is arbitrary
        end
        if press > 0 and isPointInRectangle(touchX, touchY, 0, 39, 12, 19) then --down
            if 90 - scrollPixels > 64 then
                scrollPixels = scrollPixels + 1
            end
        end
        if press == 2 and isPointInRectangle(touchX, touchY, 14, 76 - scrollPixels, 42, 10) then debug = not debug end
    end

    output.setNumber(1, scrollPixels)
    output.setBool(1, debug)
end

function onDraw()
    local _ = _colors[theme]
    if acc then

----------[[* MAIN OVERLAY *]]--
        if app == 1 then --map
            if mx == 0 then ax = x else ax = mx end --actual X
            if my == 0 then ay = y else ay = my end --actual Y
            if press == 2 and isPointInRectangle(touchX, touchY, 15, 13, 96, 64) then mx, my = map.screenToMap(ax, ay, zoom, 96, 64, touchX, touchY) end --masterX, masterY

            screen.drawMap(ax, ay, zoom)

            c(_[2][1], _[2][2], _[2][3])
            screen.drawCircle(48, 32, 1)
            dx, dy = map.mapToScreen(ax, ay, zoom, 96, 64, x, y) --drawX, drawY 
            drawPointer(dx, dy, compass, 5)

            if wx ~= 0 then --if waypoint is active
                -- find waypoint coords and draw the line from player to it
                dx2,dy2 = map.mapToScreen(ax,ay, zoom, 96, 64, wx, wy)
                screen.drawLine(dx2, dy2, dx, dy)

                --draw the waypoint
                c(_[3][1], _[3][2], _[3][3])
                screen.drawCircle(dx2,dy2,1)

                --find midpoint of line and draw distance in box
                c(200,200,200)
                sx, sy = (dx+dx2)/2, (dy+dy2)/2 --averageX, averageY
                tempx, tempy = map.screenToMap(ax, ay, zoom, 96, 64, dx, dy)
                tempx2, tempy2 = map.screenToMap(ax, ay, zoom, 96, 64, dx2, dy2)
                dist = math.sqrt((tempx2 - tempx)*(tempx2 - tempx) + (tempy2 - tempy)*(tempy2 - tempy)) --should give us world distance
                dist = dist/1000
                if zoom < dist * 4 then 
                    text = ("%.1fk"):format(dist)
                    drawRoundedRect(math.floor(sx-10), math.floor(sy-10), #text*5+5, 8) 
                    c(_[2][1], _[2][2], _[2][3])
                    screen.drawText(sx-8, sy-8, text)
                end
            end

            c(_[1][1], _[1][2], _[1][3], 250)
            tx = "X:"..("%.1fk"):format(ax/1000)
            ty = "Y:"..("%.1fk"):format(ay/1000)
            drawRoundedRect(54, 46, #ty*5+5, 16)
            drawRoundedRect(14, 53, 37, 9)
            c(200, 200, 200)
            screen.drawText(55, 49, tx)
            screen.drawText(55, 55, ty)
            screen.drawLine(17,54,48,54)
            screen.drawLine(17,53,17,54)
            screen.drawLine(47,53,47,54)
            screen.drawText(16, 56, string.format("%.2fkm", zoom))
        end

        if app == 2 then --info, dont question the app order
            c(70, 70, 70)
            screen.drawRectF(0, 15, 96, 64)
            c(200, 200, 200)
            screen.drawText(15, 18-scrollPixels, "Car Model")
            screen.drawText(15, 36-scrollPixels, "OS Version")
            screen.drawText(15, 54-scrollPixels, "OS Build")
            c(150, 150, 150)
            drawRoundedRect(15, 24-scrollPixels, #carname*5 + 2, 8)
            drawRoundedRect(15, 42-scrollPixels, #SENCAR_VERSION*5 + 2, 8)
            drawRoundedRect(15, 61-scrollPixels, #SENCAR_VERSION_BUILD*5 + 2, 8)
            drawRoundedRect(15, 77-scrollPixels, 40, 8)
            drawToggle(45, 80-scrollPixels, debug)
            c(50, 50, 50)
            screen.drawText(17, 26-scrollPixels, carname)
            screen.drawText(17, 44-scrollPixels, SENCAR_VERSION)
            screen.drawText(17, 63-scrollPixels, SENCAR_VERSION_BUILD)
            screen.drawText(17, 79-scrollPixels, "debug")
        end

----------[[* CONTROLS OVERLAY *]]--
        c(_[1][1], _[1][2], _[1][3], 250)
        screen.drawRectF(0, 15, 13, 64)

        if app == 1 then
            --zoom icons
            c(170, 170, 170)
            screen.drawRect(1, 16, 10, 10)
            screen.drawRect(1, 28, 10, 10)
            screen.drawRect(1, 40, 10, 10)
            screen.drawRect(1, 52, 10, 10)
            screen.drawText(5, 43, "R")
            screen.drawLine(4, 33, 9, 33)
            screen.drawLine(4, 21, 9, 21)
            screen.drawLine(6, 19, 6, 24)
            if wx == 0 then screen.drawText(5, 55, "W") else screen.drawText(5, 55, "C") end
        end

        if app == 2 then
            c(200, 200, 200)
            screen.drawRect(1, 19, 10, 18)
            screen.drawRect(1, 40, 10, 18)
            screen.drawTriangleF(3, 29, 6, 25, 10, 29)
            screen.drawTriangleF(2, 48, 6, 53, 11, 48)
        end
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

function clamp(value, lower, upper)
    return math.min(math.max(value, lower), upper)
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