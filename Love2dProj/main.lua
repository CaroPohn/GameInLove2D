function love.load()
    chickenX = 150
    chickenY = 144

    chicken = love.graphics.newImage("idleChicken.png")
    road = love.graphics.newImage("road.png")
    love.window.setMode(1280, 720)
end

function love.update(dt)
    love.keypressed(key)
end

function love.draw()
    love.graphics.draw(road, 0, 0, 0, 1, 1)
    love.graphics.draw(chicken, chickenX, chickenY, 0, 2, 2)
end

function love.keypressed(key)
    if key == "s" then
        chickenY = chickenY + 144
    end
    if chickenY > 504 then
        chickenY = 216
    end
    if chickenY < 216 then
        chickenY = 216
    end

    if key == "w" then
        chickenY = chickenY - 144
    end
    if chickenY > 504 then
        chickenY = 216
    end
    if chickenY < 216 then
        chickenY = 504
    end
end