--start_animation
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
    simulator:setScreen(1, "3x1")
    simulator:setProperty("Theme", 1)
    simulator:setProperty("Car name", "SenCar_5 DEV")

    -- Runs every tick just before onTick; allows you to simulate the inputs changing
    ---@param simulator Simulator Use simulator:<function>() to set inputs etc.
    ---@param ticks     number Number of ticks since simulator started
    function onLBSimulatorTick(simulator, ticks)

        -- touchscreen defaults
        local screenConnection = simulator:getTouchScreen(1)
        simulator:setInputBool(1, simulator:getIsToggled(1))
    end;
end
---@endsection


--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!

_colors = {
    {{47,51,78}, {86,67,143}, {128,95,164}}, --sencar 5 in the micro
    {{17, 15, 107}, {22, 121, 196}, {48, 208, 217}}, --blue
    {{74, 27, 99}, {124, 42, 161}, {182, 29, 224}} --purple
}

ticks = 0
tick = 0 --tick is lerp
done = false
function onTick()
    acc = input.getBool(1)
    theme = input.getNumber(32)
    car = property.getText("Car name")
    if acc then
        if ticks < 150 then
            ticks = ticks + 1
        end
    else
        ticks = 0
        done = false
    end
    if ticks == 150 then
        done = true
    end

    if done and tick < 1 then
        tick = tick + 0.05
    end
    if not done and tick > 0 then
        tick = tick - 0.05
    end
    output.setBool(1, done)
    output.setNumber(1, ticks)
end

function onDraw()
    local _ = _colors[theme]
    if acc then
    --if not done then
        alpha = lerp(255, 1, tick)
        c(_[2][1], _[2][2], _[2][3], alpha)
        screen.drawRectF(0,0,96,32)

            if ticks > 20 then
                screen.setColor(200,200,200, alpha)
                screen.drawCircle(16,15,8)
                c(_[2][1], _[2][2], _[2][3], alpha)
                screen.drawRectF(4,11,32,32)
                if ticks > 40 then
                    screen.setColor(200,200,200, alpha)
                    screen.drawCircle(16,11,3)
                    c(_[2][1], _[2][2], _[2][3], alpha)
                    screen.drawRectF(16,9,4,6)
                    if ticks > 60 then
                        screen.setColor(200,200,200, alpha)
                        screen.drawCircle(16,17,3)
                        c(_[2][1], _[2][2], _[2][3], alpha)
                        screen.drawRectF(12,15,4,6)
                        if ticks > 80 then
                            screen.setColor(200,200,200, alpha)
                            screen.drawText(12,22,"ST")
                            screen.drawText(30,14,car)
                        end
                    end
                end
            end
        end
    --end
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