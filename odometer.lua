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
    simulator:setScreen(1, "3x3")
    simulator:setProperty("ExampleNumberProperty", 123)

    -- Runs every tick just before onTick; allows you to simulate the inputs changing
    ---@param simulator Simulator Use simulator:<function>() to set inputs etc.
    ---@param ticks     number Number of ticks since simulator started
    function onLBSimulatorTick(simulator, ticks)

        -- touchscreen defaults
        local screenConnection = simulator:getTouchScreen(1)
        simulator:setInputBool(1, screenConnection.isTouched)
        simulator:setInputNumber(1, screenConnection.width)
        simulator:setInputNumber(2, screenConnection.height)
        simulator:setInputNumber(3, screenConnection.touchX)
        simulator:setInputNumber(4, screenConnection.touchY)

        -- NEW! button/slider options from the UI
        simulator:setInputBool(31, simulator:getIsClicked(1))       -- if button 1 is clicked, provide an ON pulse for input.getBool(31)
        simulator:setInputNumber(31, simulator:getSlider(1))        -- set input 31 to the value of slider 1

        simulator:setInputBool(32, simulator:getIsToggled(2))       -- make button 2 a toggle, for input.getBool(32)
        simulator:setInputNumber(32, simulator:getSlider(2) * 50)   -- set input 32 to the value from slider 2 * 50
    end;
end
---@endsection


--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!

ticks = 0
eng = false
odometer = 0
speeds = {}
fuelStart = 0
fuelEnd = 0
avgSpeed = 0
fuelEcon = 0
distance = 0

function onTick()
    pulse = input.getBool(1) and not eng
    eng = input.getBool(1)
    pulse2 = input.getBool(2)
    speed = input.getNumber(1)
    fuel = input.getNumber(2)
    Unit = property.getBool("Units")

    if pulse then --get the starting fuel when the engine turns on
        fuelStart = fuel
        distance = 0
        fuelEcon = 0
        avgSpeed = 0
        speeds = {}
        fuelEnd = 0
    end

    if pulse2 and fuelStart ~= 0 then
        fuelEnd = fuel
    end

    if eng and ticks%30 == 0 then --every half second, update the odometer driven by adding the current speed in m/t to the odometer
        odometer = odometer + speed/2
        distance = distance + speed/2
        speeds[#speeds+1] = speed
    end

    if not eng and fuelStart ~= 0 then --when the engine turns off, calculate the fuel used, average speed and fuel economy
        fuelUsed = math.abs(fuelStart - fuelEnd)
        for i = 1, #speeds do
            avgSpeed = avgSpeed + speeds[i]
        end

        if Unit then --mpg
            fuelEcon = (fuelUsed/3.785)/(distance/1609.34) --miles / gallon
        else --l/100km
            fuelEcon = fuelUsed / (distance * 1000 * 100) --idk blame nameous
        end

        avgSpeed = avgSpeed / #speeds
    end
    
    ticks = ticks + 1

	if Unit then --miles
		output.setNumber(1,odometer/1609)
        output.setNumber(2, fuelEcon)
        output.setNumber(3, avgSpeed*2.23)
	else --km
		output.setNumber(1,odometer/1000)
        output.setNumber(2, fuelEcon)
        output.setNumber(3, avgSpeed*3.6)
	end
end