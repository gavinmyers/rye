local board = require 'com.layout.board'
local function main()
  local b = board:create("GAME")
  b.playerX = 0
  b.playerY = 0

  function b:_draw()
    local screenWidth, screenHeight = love.window.getDimensions()
    love.graphics.setColor(125,125,125)
    love.graphics.rectangle("fill",0,0,screenWidth,screenHeight)

    love.graphics.setColor(0,255,255)
    love.graphics.rectangle("fill",self.playerX,self.playerY,16,16) 
  end

  function b:_update(dt)
    local speed = 80 
    local dx, dy = 0, 0
    if love.keyboard.isDown('right') then
      dx = speed * dt
    elseif love.keyboard.isDown('left') then
      dx = -speed * dt
    end
    if love.keyboard.isDown('down') then
      dy = speed * dt
    elseif love.keyboard.isDown('up') then
      dy = -speed * dt
    end
    self.playerX = self.playerX + dx
    self.playerY = self.playerY + dy
  end

  function b:_keypressed(k)
    if k=="escape" then 
      love.event.quit() 
    end
  end
end
main()
