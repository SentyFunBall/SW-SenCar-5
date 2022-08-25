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
                drawRoundedRect(3, 3, 25, 25)
                active.slot1.id = widget.id
                active.slot1.occupied = true
                widget.drawn = true
            else
                if active.slot1.id == widget.id then
                    drawRoundedRect(3, 3, 25, 25)
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

function drawRoundedRect(x, y, w, h)
    screen.drawRectF(x+1, y+1, w-1, h-1) --body
    screen.drawLine(x+1, y, x+w, y) --top
    screen.drawLine(x, y+1, x, y+h) --left
    screen.drawLine(x+w, y+1, x+w, y+h) --right
    screen.drawLine(x+1, y+h, x+w, y+h) --bottom
end