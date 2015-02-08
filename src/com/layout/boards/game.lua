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

    function b:init()
      self.world = bump.newWorld()
      self.light = love.light.newWorld() 
      self.light.setAmbientColor(150,150,150)
      self.light.clearBodys()
      local tileW = 32 
      local tileH = 32 
      self.player = b:get(b:add(tile:new("ACTOR")).id) --roundabout way to prove all this works
      self.player.l = tileW * 2 
      self.player.t = tileH * 2 
      self.player.w = math.floor(tileW * 0.8) 
      self.player.h = math.floor(tileH * 0.8) 
      self.player.light = self.light.newLight(0,0,255,255,255,100)
      self.player.light.setPosition(self.player.l, self.player.t)
      self.world:add(self.player.id, 
        self.player.l + (self.player.w / 2), 
        self.player.t + (self.player.h / 2), 
        self.player.w / 4, 
        self.player.h / 4) 
      for x,xv in pairs(d.map) do
        for y,yv in pairs(xv) do
          local n = math.floor(yv)
          if n == 255 then
            local gnd = b:add(tile:new("GROUND",{map=d.map})) -- TODO: get around passing the map
            gnd.l = x * tileW 
            gnd.t = y * tileH
            gnd.x = x
            gnd.y = y
            gnd.w = tileW 
            gnd.h = tileH 
            gnd:batch()
          elseif n == 1 then
            local wall = b:add(tile:new("WALL",{map=d.map}))
            wall.l = x * tileW
            wall.t = y * tileH
            wall.x = x
            wall.y = y
            wall.w = tileW 
            wall.h = tileH 
            wall:batch()
            self.world:add(wall.id, wall.l, wall.t, wall.w, wall.h)
            self.light.newRectangle(wall.l, wall.t, wall.w, wall.h)
          end
        end
      end
      return self
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
      --bump_debug.draw(self.world)
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

      local fx = math.floor((self.player.l + (self.player.w / 2)) + dx)
      local fy = math.floor((self.player.t + (self.player.h / 2)) + dy)
      local collisions, len = self.world:check(self.player.id,fx,fy)
      local canMove = len == 0 

      if canMove == false then
        fx = math.floor((self.player.l + (self.player.w / 2)) + 0)
        fy = math.floor((self.player.t + (self.player.h / 2)) + dy)
        collisions, len = self.world:check(self.player.id,fx,fy)
        canMove = len == 0 
      end
      
      if canMove == false then
        fx = math.floor((self.player.l + (self.player.w / 2)) + dx)
        fy = math.floor((self.player.t + (self.player.h / 2)) + 0)
        collisions, len = self.world:check(self.player.id,fx,fy)
        canMove = len == 0 
      end

      if canMove == true then
        if dx > 0 then 
          self.player.direction = "E"
        elseif dx < 0 then
          self.player.direction = "W"
        end
        if dy > 0 then 
          self.player.direction = "S"
        elseif dy < 0 then
          self.player.direction = "N"
        end

        self.player.l = self.player.l + dx 
        self.player.t = self.player.t + dy 
        self.player:update(dt)
        self.player.light.setPosition(self.player.l, self.player.t)
        self.world:move(self.player.id, fx, fy) 
      end
    end

    function b:_keypressed(k)
      if k=="escape" then 
        love.event.quit() 
      end
    end

    return b:init()
  end

  return gen
end
main()
