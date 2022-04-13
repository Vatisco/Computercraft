
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

function GoToPos(x,y,z)

end

function Refuelling()

end

function EmptyInventory()
    
end

function Excavate()

end

function MoveDown()
    turtle.digDown()
    turtle.suckDown()
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
    Excavate()
end

main()