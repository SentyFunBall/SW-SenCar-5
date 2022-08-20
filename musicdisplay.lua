--musicdisplay
-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Workshop: <WorkshopLink>

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
    simulator:setScreen(1, "1x1")
    simulator:setProperty("Theme", 1) --we dont have the "Use Drive Modes" property because that is handled by the transmission


    -- Runs every tick just before onTick; allows you to simulate the inputs changing
    ---@param simulator Simulator Use simulator:<function>() to set inputs etc.
    ---@param ticks     number Number of ticks since simulator started
    function onLBSimulatorTick(simulator, ticks)

        -- touchscreen defaults
        local screenConnection = simulator:getTouchScreen(1)
        simulator:setInputNumber(1, 1)
        simulator:setInputNumber(2, 0.9423432)
        simulator:setInputNumber(31, screenConnection.touchX)
        simulator:setInputNumber(32, screenConnection.touchY)

        -- NEW! button/slider options from the UI
        simulator:setInputBool(1, true)
        simulator:setInputBool(2, simulator:getIsToggled(2))
    end;
end
---@endsection

--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!
require("LifeBoatAPI")

_colors = {
    {{47,51,78}, {86,67,143}, {128,95,164}}, --sencar 5 in the micro
    {{17, 15, 107}, {22, 121, 196}, {48, 208, 217}} --blue
}
ticks = 0
godown = false

function onTick()
    acc = input.getBool(1)
    theme = property.getNumber("Theme")

    channel = math.ceil(input.getNumber(1))
    signalStrength = string.format("%.0f", input.getNumber(2)*100)
    data = input.getNumber(3) --from radio, not used
    isPlayingMusic = input.getBool(2)
end

function onDraw()
    local _ = _colors[theme]
    if acc then
        for i = 1, 33 do
            c(lerp(_[2][1], _[3][1], i/32), lerp(_[2][2], _[3][2], i/32), lerp(_[2][3], _[3][3], i/32))
            screen.drawLine(i-1, 0, i-1, 32)
        end

        --background
        if not isPlayingMusic then
            c(_[1][1], _[1][2], _[1][3],250) --i love tables
            screen.drawRectF(3,3,26,26)
            screen.drawLine(4,2,28,2)
            screen.drawLine(29,4,29,28)
            screen.drawLine(4,29,28,29)
            screen.drawLine(2,4,2,28)
            ticks = 0
        else
            c(lerp(_[1][1], (_[1][1] + _[3][1])/2, ticks/300), lerp(_[1][2], (_[1][2] + _[3][2])/2, ticks/300), lerp(_[1][3], (_[1][3] + _[3][3])/2, ticks/300), 250)
            screen.drawRectF(3,3,26,26)
            screen.drawLine(4,2,28,2)
            screen.drawLine(29,4,29,28)
            screen.drawLine(4,29,28,29)
            screen.drawLine(2,4,2,28)
            if ticks == 300 then
                godown = true
            end
            if ticks == 0 then
                godown = false
            end
            if not godown then
                ticks = ticks + 1
            else
                ticks = ticks - 1
            end
        end

        -- stupid button outlines
        c(_[1][1]+55, _[1][2]+55, _[1][3]+55, 250)
        screen.drawLine(3,20,29,20)
        screen.drawRectF(15,21,2,8)

        screen.drawLine(16,28,26,28)
        screen.drawLine(26,27,27,27)
        screen.drawLine(27,26,28,26)
        screen.drawLine(28,21,28,26)

        screen.drawLine(6,28,15,28)
        screen.drawLine(5,27,6,27)
        screen.drawLine(4,26,5,26)
        screen.drawLine(3,21,3,26)
        
        --- text
        c(_[2][1], _[2][2], _[2][3])
        screen.drawText(4,4, "Ch:" .. channel)
        screen.drawText(4,11, "SS:" .. signalStrength)

        --- up arrow
        screen.drawLine(9,22,9,27)
        screen.drawLine(10,23,10,25)
        screen.drawLine(8,23,8,25)
        screen.drawRectF(11,24,1,1)
        screen.drawRectF(7,24,1,1)

        --- down arrow
        screen.drawLine(22,22,22,27)
        screen.drawLine(23,24,23,26)
        screen.drawLine(21,24,21,26)
        screen.drawRectF(24,24,1,1)
        screen.drawRectF(20,24,1,1)
    end
end

function c(...) local _={...}
    for i,v in pairs(_) do
     _[i]=_[i]^2.2/255^2.2*_[i]
    end
    screen.setColor(table.unpack(_))
end

function lerp(v0,v1,t)
    return v1*t+v0*(1-t)
end