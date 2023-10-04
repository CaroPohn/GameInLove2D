function love.load()
    anim8 = require "anim8"
    
    chickenX = 150
    chickenY = 72

    --chicken = love.graphics.newImage("idleChicken.png")
    chicken = love.graphics.newImage("pollito.png")
    road = love.graphics.newImage("road.png")
    love.window.setMode(1150, 720)
    width = 1150
    height = 720

    -- paths of the road
    firstPath = ((1.0/5.0 * height ) + (1.0/5.0 * height / 2 ) ) - 50;
    thirdPath = ((1.0/5.0 * height ) * 3) + 42
    pastThirdPath = height - ((1.0/5.0 * height ) + (1.0/5.0 * height / 2 ) )
    chickenMovement = (1.0/5.0 * height) + 10
    carX = width
    carY = firstPath
    carSpeed = 900
    time = 0
    
    chickenGrid = anim8.newGrid(50, 40, chicken:getWidth(), chicken:getHeight())
    chickenAnimation = anim8.newAnimation(chickenGrid("1-5", 1), 0.1 )
    
    --myTimer = newTimer(6 , car(dt))

end

function love.update(dt)
    love.keypressed(key)
    carX = carX - carSpeed * dt
    time = time + love.timer.getDelta()
    chickenAnimation:update(dt)
    if time > 6 then 
        reset()
    end
    --if not myTimer.isExpired() then myTimer.update(dt) end
end

function love.draw()
    love.graphics.draw(road, 0, 0, 0, 1, 1)
    rectangleDrawing()
    chickenAnimation:draw(chicken, chickenX, chickenY, nil, 2)
end

-- Checks if key is pressed
function love.keypressed(key)
    if key == "s" or key == "S" then
        chickenY = chickenY + chickenMovement
    end
    if chickenY > pastThirdPath then
        chickenY = firstPath
    end

    if key == "w" or key == "W" then
        chickenY = chickenY - chickenMovement
    end
    if chickenY < firstPath then
        chickenY = thirdPath
    end
end

function rectangleDrawing() 
    love.graphics.rectangle( "fill", carX, carY, 50, 50)
end

function reset()
    time = 0
    carX = width
end


