
--Y level selector & excavate selector
--Refuelling after dropping below 5000
--dropping items into inventory behind start point
--Recording start point
--Returning to start once inventory is full and bedrock is reached
--remembering start position

--Going back to storage - Need to go to 0,0 before going up

local x_pos = 0  -- +Forward and -back
local y_pos = 0  -- +Up and -down
local z_pos = 0  -- -Left(west) and +right(east)
local saved_x_pos = 0
local saved_y_pos = 0
local saved_z_pos = 0
-- orientation (0 = N, 1 = E, 2 = S, 3 = W (Relative from beginning pos))
local orientation = 0
local saved_orientation = 0


function Orientate(Direction)
    if Direction == 0 then
        if orientation == 0 then
        else
            while not orientation == 0 do
                TurnLeft()
            end
        end
    elseif Direction == 1 then
        if orientation == 1 then
        else
            while not orientation == 1 do
                TurnLeft()
            end
        end
    elseif Direction == 2 then
        if orientation == 2 then
        else
            while not orientation == 2 do
                TurnLeft()
            end
        end
    elseif Direction == 3 then
        if orientation == 3 then
        else
            while not orientation == 3 do
                TurnLeft()
            end
        end
    end
end

function GoToPos(targetx,targety,targetz)
    if turtle.detectUp() then
        MoveUp()
    end
    while not GoToPosStep(targetx, targety, targetz) do
    end
end

function GoToPosStep(targetx, targety, targetz)
    -- needs to move north
    if targetx > x_pos then
        Orientate(0)
        MoveForward()
    elseif targetx < x_pos then
        -- needs to move south
        Orientate(2)
        MoveForward()
    elseif targetz > z_pos then
        -- needs to move east
        Orientate(1)
        MoveForward()
    elseif targetz < z_pos then
        -- needs to move west
        Orientate(3)
        MoveForward()
    elseif targety > y_pos then
        -- needs to move up
        MoveUp()
    elseif targety < y_pos then
        MoveDown()
    elseif targetx == x_pos and targety == y_pos and targetz == z_pos then
        return true
    else
        return false
    end
end

function Refuelling()
    local fuellevel = turtle.getFuelLevel()
    if fuellevel >= 5000 then
        local level = turtle.getFuelLevel()
        local ok, err = turtle.refuel()
        if ok then
            local new_level = turtle.getFuelLevel()
            print(("Refuelled %d, current level is %d"):format(new_level - level, new_level))
        else
            print(err)
        end
    end
end

function EmptyInventory()
    saved_orientation = orientation
    saved_x_pos = x_pos
    saved_z_pos = z_pos
    saved_y_pos = y_pos
    GoToPos(0,0,0)
    local hasfuel = false
    Orientate(2)
    for i=0,16 do
        select(i)
        if Isfuel() and not hasfuel then
            hasfuel = true
        elseif not Isfuel then
            turtle.drop()
        end
    end
    GoToPos(saved_x_pos, saved_y_pos, saved_z_pos)
    Orientate(saved_orientation)
end

function Isfuel()
    local is_fuel = turtle.refuel(0)
    return is_fuel
end

function Excavate(x, z)
    Mineable = false
    while Mineable == true do
        MoveDown()
        Orientate(0)
        for i=0,x do
            MoveForward()
        end
    end
end

function PickupDown()
    local pickup = turtle.suckDown()
    if not pickup then
        EmptyInventory()
    end
end

function Pickup()
    local pickup = turtle.suck()
    if not pickup then
        EmptyInventory()
    end
end
function TurnLeft()
    turtle.turnLeft()
    if orientation == 0 then
    orientation = 3
    elseif orientation > 0 and orientation < 4 then
        orientation = orientation - 1
    end

end

function TurnRight()
    turtle.turnRight()
    if orientation == 3 then
        orientation = 0
    elseif orientation >= 0 and orientation < 4 then
        orientation = orientation + 1
    end
end

function MoveDown()
    if turtle.detectDown() then
        turtle.digDown()
        PickupDown()
    end
    m = turtle.down()
    if m then 
        y_pos = y_pos -1
    end
    return m
end

function MoveForward()
    if turtle.detect() then
        turtle.dig()
        Pickup()
    end
    m = turtle.MoveForward()
    if m then
        if orientation == 0 then
            x_pos = x_pos + 1
        elseif orientation == 1 then
            z_pos = z_pos + 1
        elseif orientation == 2 then
            x_pos = x_pos - 1
        elseif orientation == 3 then
            z_pos = z_pos - 1
        end
    end
    return m
end

function MoveUp()
    if turtle.detectUp() then
        turtle.digUp()
    end
    m = turtle.MoveUp()
    if m then
        y_pos = y_pos +1
    end
    return m
end

function main()
    term.clear()
    term.setCursorPos(1,1)
    print("Beginning Excavation program")
    print("")
    print("How many blocks down before excavation starts:")
    print("")
    TargetStartY = math.abs(tonumber(io.read()))
    TargetStartY = -TargetStartY
    print("What dimensions?")
    print("")
    term.write("Width (Going to the right of the turtle):")
    z = math.abs(tonumber(io.read()))
    term.write("Length (Going forward):")
    x = math.abs(tonumber(io.read()))
    print("Excavation started")
    while TargetStartY <= y_pos do
        MoveDown()
    end
    Excavate(z, x)
end

main()