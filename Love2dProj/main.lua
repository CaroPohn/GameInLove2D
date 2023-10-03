function love.load()
    chickenX = 150
    chickenY = 72


    chicken = love.graphics.newImage("idleChicken.png")
    road = love.graphics.newImage("road.png")
    love.window.setMode(1150, 720)
    width = 1150
    height = 720

    -- paths of the road
    firstPath = ((1.0/5.0 * height ) + (1.0/5.0 * height / 2 ) ) - 50;
    thirdPath = ((1.0/5.0 * height ) * 3) + 42
    pastThirdPath = height - ((1.0/5.0 * height ) + (1.0/5.0 * height / 2 ) )
    chickenMovement = (1.0/5.0 * height) + 10

    
    myTimer = newTimer(6 , car(dt))

end

carX = width
carY = firstPath

function love.update(dt)
    love.keypressed(key)
    if not myTimer.isExpired() then myTimer.update(dt) end
end

function love.draw()
    love.graphics.draw(road, 0, 0, 0, 1, 1)
    love.graphics.draw(chicken, chickenX, chickenY, 0, 2, 2)
    car = love.graphics.rectangle( "fill", carX, carY, 2, 2)
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
-- Timer
function newTimer(time,callback)
    local expired = false
    local timer = {}
    
    function timer.update(dt)
         if time < 0 then
               expired = true
               callback()
         end
         time = time - dt         
    end

    function timer.isExpired()
        return expired
    end

    return timer
end

function car(dt)    
    carX = carX - 10


end