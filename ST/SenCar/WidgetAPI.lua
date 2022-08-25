-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Workshop: 

--Code by STCorp. Do not reuse.--
--- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--- If you have any issues, please report them here: https://github.com/nameouschangey/STORMWORKS_VSCodeExtension/issues - by Nameous Changey

require("LifeBoatAPI")

active= {slot1 = {large = false, occupied = false, id = -1}, slot2 = {large = false, occupied = false, id = -1}, slot3 = {large = false, occupied = false, id = -1}}

WidgetAPI = {

    draw = function (slot, large, widget)
        widget.drawn = false
        if slot == 1 then
            if not active.slot1.occupied then
                screen.drawCircle(5, 5, 5)
                active.slot1.id = widget.id
                active.slot1.occupied = true
                widget.drawn = true
            else
                if active.slot1.id == widget.id then
                    screen.drawCircle(5, 5, 5)
                    widget.drawn = true
                end
            end
        elseif slot == 2 then
            
        elseif slot == 3 then
        
        end
        return widget
    end,

    getInfo = function (widget)
        return widget
    end
}