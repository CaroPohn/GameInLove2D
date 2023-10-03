function love.load()
    x = 100
    y = 300

    sheep = love.graphics.newImage("sheep.png")
    love.window.setMode(1080, 720)
end

function love.update(dt)
    input(dt)
end

function love.draw()
    love.graphics.draw(sheep, x, y, 2, 2, 2)
end

function input(dt)
    if love.keyboard.isDown("right") then
        x = x + 100 * dt
    end
    
    if love.keyboard.isDown("left") then
        x = x - 100 * dt
    end

    if love.keyboard.isDown("up") then
        y = y - 100 * dt
    end
    
    if love.keyboard.isDown("down") then
        y = y + 100 * dt
    end
end
