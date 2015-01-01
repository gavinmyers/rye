local board = require 'com.layout.board'
local tile = require 'com.layout.tile'

local function main()
  local gen = board:create("GAME")

  function gen:_new(d)
    local b = board:create("GAME-"..math.random(1000,9999).."-"..math.random(1000,9999))
    b.player = b:get(b:add(tile:new("ACTOR")).id) --roundabout way to prove all this works
    b.player.l = 16
    b.player.t = 16 
    b.map = d.map

    for x,xv in pairs(b.map) do
      for y,yv in pairs(xv) do
        local d = math.floor(yv)
        if d == 255 then
          local gnd = b:add(tile:new("GROUND"))
          gnd.l = x * 6
          gnd.t = y * 6
          gnd.w = 5
          gnd.h = 5
        end
      end
    end

    function b:_draw()
      local screenWidth, screenHeight = love.window.getDimensions()

      love.graphics.setColor(125,125,125)
      love.graphics.rectangle("fill",0,0,screenWidth,screenHeight)

      for k, v in pairs(self:get()) do
        for k2, v2 in pairs(v) do
          v2:draw()
        end
      end
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
    return b
  end

  return gen
end
main()
