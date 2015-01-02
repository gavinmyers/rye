local board = require 'com.layout.board'
local tile = require 'com.layout.tile'
local bump = require 'lib/bump'
local shader = require 'lib/postshader'
local light = require 'lib/light'
local bump_debug = require 'lib/bump_debug'

local function main()
  local gen = board:create("GAME")

  function gen:_new(d)
    local b = board:create("GAME-"..math.random(1000,9999).."-"..math.random(1000,9999))
    b.world = bump.newWorld()
    b.light = love.light.newWorld() 
    b.light.clearBodys()
    b.lightSource = b.light.newLight(255,255,255,255,255,300)
    local tileW = 12
    local tileH = 12 
    b.player = b:get(b:add(tile:new("ACTOR")).id) --roundabout way to prove all this works
    b.player.l = 32 
    b.player.t = 32 
    b.player.w = tileW -6
    b.player.h = tileH -6
    b.lightSource.setPosition(b.player.l, b.player.t)
    b.world:add(b.player.id, b.player.l, b.player.t, b.player.w, b.player.h)
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
          b.world:add(wall.id, wall.l, wall.t, wall.w, wall.h)
          b.light.newRectangle(wall.l, wall.t, wall.w, wall.h)
        end
      end
    end

    function b:_draw()
      local screenWidth, screenHeight = love.window.getDimensions()
      love.graphics.setColor(125,125,125)
      love.graphics.rectangle("fill",0,0,screenWidth,screenHeight)

      tile:get("GROUND"):draw()
      for k, v in pairs(self:get()) do
        for k2, v2 in pairs(v) do
          v2:draw()
        end
      end
      tile:get("WALL"):draw()
      self.light.update()
      self.light.drawShadow()
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

      if dx == 0 and dy == 0 then
        return
      end

      local fx = math.floor(self.player.l + dx)
      local fy = math.floor(self.player.t + dy)
      local collisions, len = self.world:check(self.player.id,fx,fy)
      local canMove = len == 0 

      if canMove == false then
        fx = math.floor(self.player.l + 0)
        fy = math.floor(self.player.t + dy)
        collisions, len = self.world:check(self.player.id,fx,fy)
        canMove = len == 0 
      end
      
      if canMove == false then
        fx = math.floor(self.player.l + dx)
        fy = math.floor(self.player.t + 0)
        collisions, len = self.world:check(self.player.id,fx,fy)
        canMove = len == 0 
      end

      if canMove == true then
        self.world:move(self.player.id, fx, fy) 
        self.player.l = fx 
        self.player.t = fy 
        self.lightSource.setPosition(self.player.l, self.player.t)
      end
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
