function love.load()
    anim8 = require "anim8"
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    chickenX = 150
    chickenY = 72
    
    math.randomseed(os.time())
    
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
    carSpeed = 800
    time = 0
    
    --first car variables
    firstCarX = width
    firstCarY = firstPath
    firstCarRandPos = 1
    firstCarTexture = love.graphics.newImage("ranita1.png")
    firstCarGrid = anim8.newGrid(170, 140, firstCarTexture:getWidth(), firstCarTexture:getHeight())
    firstCarAnimation = anim8.newAnimation(firstCarGrid("1-8", 1), 0.1 ) 
    
    
    chickenGrid = anim8.newGrid(50, 40, chicken:getWidth(), chicken:getHeight())
    chickenAnimation = anim8.newAnimation(chickenGrid("1-5", 1), 0.1 )

end

function love.update(dt)
    love.keypressed(key)
    
    firstCarX = firstCarX - carSpeed * dt
    time = time + love.timer.getDelta()

    if time > 2 then

        firstCarRandPos = math.random(3)

        if firstCarRandPos == 1 then
            firstCarY = firstPath - 15

        elseif firstCarRandPos == 2 then
            firstCarY = firstPath + chickenMovement - 15

        elseif firstCarRandPos == 3 then
            firstCarY = thirdPath - 15

        end

        reset()
    end

    chickenAnimation:update(dt)
    firstCarAnimation:update(dt)
    --if not myTimer.isExpired() then myTimer.update(dt) end
end

function love.draw()
    love.graphics.draw(road, 0, 0, 0, 1, 1)
    --rectangleDrawing()
    chickenAnimation:draw(chicken, chickenX, chickenY, nil, 2)
    firstCarAnimation:draw(firstCarTexture, firstCarX, firstCarY)
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
    love.graphics.rectangle("fill", carX, carY, 50, 50)
end

function reset()
    time = 0
    firstCarX = width
end


