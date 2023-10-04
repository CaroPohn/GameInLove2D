function love.load()
    anim8 = require "anim8"
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    chickenX = 150
    chickenY = 72
    
    math.randomseed(os.time())
    
    -- chicken = love.graphics.newImage("idleChicken.png")
    chicken = love.graphics.newImage("pollito.png")
    road = love.graphics.newImage("road.png")
    love.window.setMode(1150, 720)
    width = 1150
    height = 720
    
    -- paths of the road
    firstPath = ((1.0/5.0 * height ) + (1.0/5.0 * height / 2 ) ) - 50;
    secondPath = height / 2 + 15
    thirdPath = ((1.0/5.0 * height ) * 3) + 42
    pastThirdPath = height - ((1.0/5.0 * height ) + (1.0/5.0 * height / 2 ) )
    chickenMovement = (1.0/5.0 * height) + 10
    carSpeed = 800
    firstCarTime = 0
    secondCarTime = 0
    thirdCarTime = 0
    
    -- first car variables
    firstCarX = width
    firstCarY = firstPath
    secondCarX = width
    secondCarY = secondPath
    thirdCarX = width
    thirdCarY = thirdPath
    firstCarRandPos = 1
    secondCarXCarRandPos = 1
    thirdCarRandPos = 1
    firstCarTexture = love.graphics.newImage("ranita1.png")
    firstCarGrid = anim8.newGrid(170, 140, firstCarTexture:getWidth(), firstCarTexture:getHeight())
    firstCarAnimation = anim8.newAnimation(firstCarGrid("1-8", 1), 0.1 ) 
    
    -- second car variables
    secondCarX = width
    secondCarY = firstPath
    secondCarRandPos = 1
    secondCarTexture = love.graphics.newImage("ranita2.png")
    secondCarGrid = anim8.newGrid(170, 140, secondCarTexture:getWidth(), secondCarTexture:getHeight())
    secondCarAnimation = anim8.newAnimation(secondCarGrid("1-8", 1), 0.1 ) 

    -- third car variables
    thirdCarX = width
    thirdCarY = firstPath
    thirdCarRandPos = 1
    thirdCarTexture = love.graphics.newImage("ranita3.png")
    thirdCarGrid = anim8.newGrid(170, 140, thirdCarTexture:getWidth(), thirdCarTexture:getHeight())
    thirdCarAnimation = anim8.newAnimation(thirdCarGrid("1-8", 1), 0.1 ) 

    chickenGrid = anim8.newGrid(50, 40, chicken:getWidth(), chicken:getHeight())
    chickenAnimation = anim8.newAnimation(chickenGrid("1-5", 1), 0.1 )

end

function love.update(dt)
    love.keypressed(key)
    
    firstCarX = firstCarX - carSpeed * dt
    secondCarX = secondCarX - carSpeed * dt
    thirdCarX = thirdCarX - carSpeed * dt
    firstCarTime = firstCarTime + love.timer.getDelta()
    secondCarTime = secondCarTime + love.timer.getDelta()
    thirdCarTime = thirdCarTime + love.timer.getDelta()

    if firstCarTime > 2 then
        firstCarRandPos = math.random(3)

        if firstCarRandPos == 1 then
            firstCarY = firstPath - 15

        elseif firstCarRandPos == 2 then
            firstCarY = firstPath + chickenMovement - 15

        elseif firstCarRandPos == 3 then
            firstCarY = thirdPath - 15

        end   
        resetFirstCar()
    end

    if secondCarTime > 3 then
        secondCarXCarRandPos = math.random(3)

        if secondCarXCarRandPos == 1 then
            secondCarY = firstPath - 15

        elseif secondCarXCarRandPos == 2 then
            secondCarY = firstPath + chickenMovement - 15

        elseif secondCarXCarRandPos == 3 then
            secondCarY = thirdPath - 15
        end

        resetSecondCar()
    end

    if thirdCarTime > 5 then
        thirdCarRandPos = math.random(3)

        if thirdCarRandPos == 1 then
            thirdCarY = firstPath - 15

        elseif thirdCarRandPos == 2 then
            thirdCarY = firstPath + chickenMovement - 15

        elseif thirdCarRandPos == 3 then
            thirdCarY = thirdPath - 15
        end

        resetThirdCar()
    end

    chickenAnimation:update(dt)
    firstCarAnimation:update(dt)
    secondCarAnimation:update(dt)
    thirdCarAnimation:update(dt)
end

function love.draw()
    love.graphics.draw(road, 0, 0, 0, 1, 1)
    chickenAnimation:draw(chicken, chickenX, chickenY, nil, 2)
    firstCarAnimation:draw(firstCarTexture, firstCarX, firstCarY)
    --love.graphics.rectangle("fill", secondCarX, secondCarY, 50, 50)
    --love.graphics.rectangle("fill", thirdCarX, thirdCarY, 50, 50)
    secondCarAnimation:draw(secondCarTexture, secondCarX, secondCarY)
    thirdCarAnimation:draw(thirdCarTexture, thirdCarX, thirdCarY)
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

function resetFirstCar()
    firstCarTime = 0
    firstCarX = width
end

function resetSecondCar()
    secondCarTime = 0
    secondCarX = width
end

function resetThirdCar()
    thirdCarTime = 0
    thirdCarX = width
end

