function love.load()
    anim8 = require "anim8"
    love.graphics.setDefaultFilter("nearest", "nearest")

    chickenX = 150
    chickenY = 72

    scoreTimer = 0
    score = 0

    isGameRunning = true
    loseGame = false
    winGame = false

    -- Semilla para el random
    math.randomseed(os.time())
    
    chicken = love.graphics.newImage("pollito.png")
    road = love.graphics.newImage("road2less.png")
    deathScreen = love.graphics.newImage("deathanimcar2.png")
    winScreen = love.graphics.newImage("winanimation.png")

    -- Setear la ventana
    love.window.setMode(1150, 720)
    screenWidth = 1150
    screenHeight = 720
    
    -- Paths of the road
    firstPath = ((1.0/5.0 * screenHeight ) + (1.0/5.0 * screenHeight / 2 ) ) - 50;
    secondPath = screenHeight / 2 - 60
    thirdPath = ((1.0/5.0 * screenHeight ) * 3) + 42
    pastThirdPath = screenHeight - ((1.0/5.0 * screenHeight ) + (1.0/5.0 * screenHeight / 2 ) )
    chickenMovement = (1.0/5.0 * screenHeight) + 10

    -- First car variables
    firstCarX = screenWidth
    firstCarY = firstPath - 15
    firstCarRandPos = 1
    firstCarTexture = love.graphics.newImage("ranita1.png")
    firstCarGrid = anim8.newGrid(170, 140, firstCarTexture:getWidth(), firstCarTexture:getHeight())
    firstCarAnimation = anim8.newAnimation(firstCarGrid("1-8", 1), 0.1 ) 
    firstCarSpeed = 700
    firstCarTime = 0

    -- Second car variables
    secondCarX = screenWidth
    secondCarY = firstPath + screenHeight
    secondCarRandPos = 1
    secondCarTexture = love.graphics.newImage("ranita2.png")
    secondCarGrid = anim8.newGrid(170, 140, secondCarTexture:getWidth(), secondCarTexture:getHeight())
    secondCarAnimation = anim8.newAnimation(secondCarGrid("1-8", 1), 0.1 ) 
    secondCarSpeed = 900
    secondCarTime = 0

    -- Third car variables
    thirdCarX = screenWidth
    thirdCarY = thirdPath - 15
    thirdCarRandPos = 1
    thirdCarTexture = love.graphics.newImage("ranita3.png")
    thirdCarGrid = anim8.newGrid(170, 140, thirdCarTexture:getWidth(), thirdCarTexture:getHeight())
    thirdCarAnimation = anim8.newAnimation(thirdCarGrid("1-8", 1), 0.1 ) 
    thirdCarSpeed = 400
    thirdCarTime = 0

    chickenGrid = anim8.newGrid(50, 40, chicken:getWidth(), chicken:getHeight())
    chickenAnimation = anim8.newAnimation(chickenGrid("1-5", 1), 0.1 )

    isColliding = false

    roadGrid = anim8.newGrid(1150, 720, road:getWidth(), road:getHeight())
    roadAnimation = anim8.newAnimation(roadGrid("1-13", 1), 0.1 ) 

    deathScreenGrid = anim8.newGrid(1150, 720, deathScreen:getWidth(), deathScreen:getHeight())
    deathScreenAnim = anim8.newAnimation(deathScreenGrid("1-13", 1), 0.1 )

    winScreenGrid = anim8.newGrid(1150, 720, winScreen:getWidth(), winScreen:getHeight())
    winScreenAnim = anim8.newAnimation(winScreenGrid("1-12", 1), 0.1 )

end

function love.update(dt)
    love.keypressed(key)

    pathCorrection = 15
    
    firstCarX = firstCarX - firstCarSpeed * dt
    secondCarX = secondCarX - secondCarSpeed * dt
    thirdCarX = thirdCarX - thirdCarSpeed * dt
    firstCarTime = firstCarTime + love.timer.getDelta() 
    secondCarTime = secondCarTime + love.timer.getDelta() 
    thirdCarTime = thirdCarTime + love.timer.getDelta() 
    scoreTimer = scoreTimer + love.timer.getDelta()

    if firstCarTime > 2 then
        firstCarRandPos = math.random(3)

        if firstCarRandPos == 1 then
            firstCarY = firstPath - pathCorrection

        elseif firstCarRandPos == 2 then
            firstCarY = secondPath

        elseif firstCarRandPos == 3 then
        firstCarY = thirdPath - pathCorrection

        end   
        resetFirstCar()
    end

    if secondCarTime > 3 then
        secondCarXCarRandPos = math.random(3)

        if secondCarXCarRandPos == 1 then
            secondCarY = firstPath - pathCorrection

        elseif secondCarXCarRandPos == 2 then
            secondCarY = secondPath

        elseif secondCarXCarRandPos == 3 then
            secondCarY = thirdPath - pathCorrection
        end

        resetSecondCar()
    end

    if thirdCarTime > 5 then
        thirdCarRandPos = math.random(3)

        if thirdCarRandPos == 1 then
            thirdCarY = firstPath - pathCorrection

        elseif thirdCarRandPos == 2 then
            thirdCarY = secondPath

        elseif thirdCarRandPos == 3 then
            thirdCarY = thirdPath - pathCorrection
        end

        resetThirdCar()
    end

    roadAnimation:update(dt)
    chickenAnimation:update(dt)
    firstCarAnimation:update(dt)
    secondCarAnimation:update(dt)
    thirdCarAnimation:update(dt)
        
    collitionWithFirstCar()
    collitionWithSecondCar()
    collitionWithThirdCar()

    scoreCounter()
   
    if loseGame == true then
        deathScreenAnim:update(dt)
    end

    if winGame == true then
        winScreenAnim:update(dt)
    end
end

function love.draw()
    -- Animations
    roadAnimation:draw(road, 0, 0)
    chickenAnimation:draw(chicken, chickenX, chickenY, nil, 2.5)
    firstCarAnimation:draw(firstCarTexture, firstCarX, firstCarY)
    secondCarAnimation:draw(secondCarTexture, secondCarX, secondCarY)
    thirdCarAnimation:draw(thirdCarTexture, thirdCarX, thirdCarY)

    if loseGame == true then 
        deathScreenAnim:draw(deathScreen, 0, 0)
    end

    if winGame == true then
        winScreenAnim:draw(winScreen, 0, 0)
    end

    if loseGame == false and winGame == false then  
        love.graphics.print(score, 25, 25, 0, 4, 4)
        love.graphics.print("Ignacio G. - Carolina P. - Santiago S.", 400, 650, 0, 1.5, 1.5)
    end

    winCondition()
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

    if key == "r" or key == "R" then 
        isGameRunning = true
        loseGame = false
        winGame = false
        score = 0
        firstCarTime = 0
        secondCarTime = 0
        thirdCarTime = 0
    end
end

function resetFirstCar()
    firstCarTime = 0
    firstCarX = screenWidth
end

function resetSecondCar()
    secondCarTime = 0
    secondCarX = screenWidth
end

function resetThirdCar()
    thirdCarTime = 0
    thirdCarX = screenWidth
end

function collitionWithFirstCar()
    if chickenX + 50 >= firstCarX + pathCorrection and chickenX <= firstCarX + 140 and chickenY + 40 >= firstCarY and chickenY <= firstCarY + 140 then 
        isColliding = true
        isGameRunning = false
        loseGame = true
    end
end

function collitionWithSecondCar()
    if chickenX + 50 >= secondCarX + pathCorrection and chickenX <= secondCarX + 140 and chickenY + 40 >= secondCarY and chickenY <= secondCarY + 140 then 
        isColliding = true
        isGameRunning = false
        loseGame = true
    end
end

function collitionWithThirdCar()
    if chickenX + 50 >= thirdCarX + pathCorrection and chickenX <= thirdCarX + 140 and chickenY + 40 >= thirdCarY and chickenY <= thirdCarY + 140 then 
        isColliding = true
        isGameRunning = false
        loseGame = true
    end
end

function scoreCounter()
    if scoreTimer > 2 then 
        score = score + 10
        scoreTimer = 0
    end   
end

function winCondition()
    if score > 750 then
        winGame = true    
    end
end
