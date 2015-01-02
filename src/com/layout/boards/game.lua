local board = require 'com.layout.board'
local tile = require 'com.layout.tile'

local function main()
  local gen = board:create("GAME")

  function gen:_new(d)
    local b = board:create("GAME-"..math.random(1000,9999).."-"..math.random(1000,9999))
    local tileW = 12 
    local tileH = 12 
    b.player = b:get(b:add(tile:new("ACTOR")).id) --roundabout way to prove all this works
    b.player.l = 32 
    b.player.t = 32 
    b.player.w = tileW
    b.player.h = tileH
    local debug_space = 0
    for x,xv in pairs(d.map) do
      for y,yv in pairs(xv) do
        local n = math.floor(yv)
        if n == 255 then
          local gnd = b:add(tile:new("GROUND",{map=d.map}))
          gnd.l = x * (tileW + debug_space) 
          gnd.t = y * (tileH + debug_space) 
          gnd.x = x
          gnd.y = y
          gnd.w = tileW 
          gnd.h = tileH 
          gnd:batch({map=d.map})
        elseif n == 1 then
          local wall = b:add(tile:new("WALL",{map=d.map}))
          wall.l = x * (tileW + debug_space) 
          wall.t = y * (tileH + debug_space) 
          wall.x = x
          wall.y = y
          wall.w = tileW 
          wall.h = tileH 
          wall:batch()
        end
      end
    end

    function b:_draw()
      local screenWidth, screenHeight = love.window.getDimensions()
      love.graphics.setColor(125,125,125)
      love.graphics.rectangle("fill",0,0,screenWidth,screenHeight)

      tile:get("GROUND"):draw()
      tile:get("WALL"):draw()
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
