local board = require 'com.layout.board'
local tile = require 'com.layout.tile'

local function main()
  local gen = board:create("GAME")

  function gen:_new(d)
    local b = board:create("GAME-"..math.random(1000,9999).."-"..math.random(1000,9999))
    local debug = {}
    for i=1,255 do
      debug[i] = {math.random(255),math.random(255),math.random(255)}
    end
    b.debug = debug
    b.player = b:get(b:add(tile:new("ACTOR")).id) --roundabout way to prove all this works
    b.map = d.map
    b.tile = d.tile
    --local w = tile:new("WALL")
    --w.l = 32
    --w.t = 32
    --b:add(w)
    --local g = tile:new("GROUND")
    --g.l = 128 
    --g.t = 128 
    --b:add(g)

    function b:_draw()
      local screenWidth, screenHeight = love.window.getDimensions()
      love.graphics.setColor(125,125,125)
      love.graphics.rectangle("fill",0,0,screenWidth,screenHeight)

      for x,xv in pairs(self.map.generation) do
        for y,yv in pairs(xv) do
          local d = math.floor(yv)
          love.graphics.setColor(self.debug[d][1],self.debug[d][2],self.debug[d][3])
          local x = x * 6
          local y = y * 6
          local w = self.tile 
          local h = self.tile 
          love.graphics.rectangle("fill",x,y,w,h)
        end
      end

      love.graphics.setColor(0,0,0)
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
