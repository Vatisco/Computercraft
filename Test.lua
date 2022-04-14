
--Y level selector & excavate selector
--Refuelling after dropping below 5000
--dropping items into inventory behind start point
--Recording start point
--Returning to start once inventory is full and bedrock is reached
--remembering start position


--Going back to storage - Need to go to 0,0 before going up
x_pos = 0
y_pos = 0
z_pos = 0
-- orientation (0 = N, 1 = E, 2 = S, 3 = W (Relative from beginning pos))
orientation = 0

function GoToPos(targetx,targety,targetz)
    while not GoToPosStep(targetx, targety, targetz) do
    end
end

function GoToPosStep(targetx, targety, targetz)

end

function Refuelling()

end

function EmptyInventory()
    GoToPos(0,0,0)
    local hasfuel = false
    while not orientation == 2 do
        TurnLeft()
    end
    for i=0,16 do
        select(i)
        if Isfuel() and not hasfuel then
            hasfuel = true
        elseif not Isfuel then
            turtle.drop()
        end
    end

end

function Isfuel()
    local is_fuel = turtle.refuel(0)
    return is_fuel
end

function Excavate(x, z)

end

function PickupDown()
    local Pickup = turtle.suckDown()
    if not Pickup then
        EmptyInventory()
    end
end

function Pickup()
    local Pickup = turtle.suck()
    if not Pickup then
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
    if turtle.detectDown then
        turtle.digDown()
        PickupDown()
    end
    m = turtle.down
    if m then 
        y_pos = y_pos -1
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