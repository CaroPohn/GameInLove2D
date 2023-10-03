function love.load()
    x = 280
    y = 144

    sheep = love.graphics.newImage("sheep.png")
    love.window.setMode(1280, 720)
end

function love.update(dt)
    input(dt)
end

function love.draw()
    love.graphics.draw(sheep, x, y, 2, 2, 2)
end

function input(dt)
    if love.keyboard.isDown("w") then
        y = y + 144
    end
    if y > 504 then
        y = 216
    end
    if y < 216 then
        y = 216
    end
end