# SenCar 5 Documentation
## Custom Functions

what did you think i stole all the code (yes)

## Contents
1. [Custom Functions](#custom-functions)
2. [WidgetAPI](#widgetapi)
3. [AppAPI](#appapi)

## Custom Functions
### drawCircle()
`drawCircle()` function used around the OS:

    --- draws an arc around pixel coords [x], [y]
    ---@param x number number The X coordinate of the center of the arc
    ---@param y number The Y coordinate of the center of the arc
    ---@param outer_rad number The distance from the outer edge of the arc to the center of the arc. AKA Radius
    ---@param inner_rad number The distance from the inner edge of the arc to the center of the arc. Set to 0 to make a circle
    ---@param step number The amount of triangles to draw the entire arc. Step size does not stay constant, and may vary with arc_ang
    ---@param begin_ang number Beginning angle of the arc in radians
    ---@param arc_ang number Angle of the entire arc in radians
    ---@param dir number Direction of the arc. Default 1, -1 for reverse.
    function drawCircle(x,y,outer_rad, inner_rad, step, begin_ang, arc_ang, dir)
    dir = dir or 1
    sin=math.sin cos=math.cos pi=math.pi pi2=math.pi*2
    step_s=pi2/step*-dir
    ba=begin_ang*dir
    ora=outer_rad
    ira=inner_rad
        for i=0, math.floor(arc_ang / (pi2 / step))-1 do
            step_p=ba+step_s*i
            step_n=ba+step_s*(i+1)
            screen.drawTriangleF(x+sin(step_p)*ora, y+cos(step_p)*ora, x+sin(step_n)*ora, y+cos(step_n)*ora, x+sin(step_p)*ira, y+cos(step_p)*ira)
            screen.drawTriangleF(x+sin(step_n)*ora, y+cos(step_n)*ora, x+sin(step_n)*ira, y+cos(step_n)*ira, x+sin(step_p)*ira, y+cos(step_p)*ira)
        end
    end