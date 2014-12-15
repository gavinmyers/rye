local board = require 'com.layout.board'
local tile = require 'com.layout.tile'
local function main()
  local b = board:create("GAME")
  b.player = b:get(b:add(tile:new("ACTOR")).id) --roundabout way to prove all this works

  function b:_draw()
    local screenWidth, screenHeight = love.window.getDimensions()
    love.graphics.setColor(125,125,125)
    love.graphics.rectangle("fill",0,0,screenWidth,screenHeight)

    self.player:draw()
  end

  function b:_update(dt)
    local speed = self.player.speed 
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
    self.player.l = self.player.l + dx
    self.player.t = self.player.t + dy
  end

  function b:_keypressed(k)
    if k=="escape" then 
      love.event.quit() 
    end
  end
end
main()
