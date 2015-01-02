local tile = require 'com.layout.tile'
local function main()
  local gen = tile:create("WALL")
  gen.image = love.graphics.newImage("com/style/DawnLike_1/Objects/Wall.png")
  gen.spritebatch = love.graphics.newSpriteBatch(gen.image,100000)

  gen.quad = {}

  function gen:split(f,w,h)
    self.quad[f] = {}
    self.quad[f]["NSEW"] = love.graphics.newQuad(w+64, h+16, 16, 16, 320, 816)
    self.quad[f][""] = love.graphics.newQuad(w+16, h+16, 16, 16, 320, 816)
    self.quad[f]["N"] = love.graphics.newQuad(w, h+16, 16, 16, 320, 816)
    self.quad[f]["S"] = love.graphics.newQuad(w, h+16, 16, 16, 320, 816)
    self.quad[f]["E"] = love.graphics.newQuad(w+16, h, 16, 16, 320, 816)
    self.quad[f]["W"] = love.graphics.newQuad(w+16, h, 16, 16, 320, 816)
    self.quad[f]["NS"] = love.graphics.newQuad(w, h+16, 16, 16, 320, 816)
    self.quad[f]["NE"] = love.graphics.newQuad(w, h+32, 16, 16, 320, 816)
    self.quad[f]["NW"] = love.graphics.newQuad(w+32, h+32, 16, 16, 320, 816)
    self.quad[f]["SE"] = love.graphics.newQuad(w, h, 16, 16, 320, 816)
    self.quad[f]["SW"] = love.graphics.newQuad(w+32, h, 16, 16, 320, 816)
    self.quad[f]["EW"] = love.graphics.newQuad(w+16, h, 16, 16, 320, 816)
    self.quad[f]["NSE"] = love.graphics.newQuad(w+48, h+16, 16, 16, 320, 816)
    self.quad[f]["NSW"] = love.graphics.newQuad(w+80, h+16, 16, 16, 320, 816)
    self.quad[f]["NEW"] = love.graphics.newQuad(w+64, h+32, 16, 16, 320, 816)
    self.quad[f]["SEW"] = love.graphics.newQuad(w+64, h, 16, 16, 320, 816)
  end

  gen:split("W0",0,0)
  gen:split("W1",0,48)

  function gen:_draw()
    love.graphics.draw(self.spritebatch)
  end

  function gen:_new(d)
    local t = tile:create("WALL-"..math.random(1000,9999).."-"..math.random(1000,9999))
    t.quad = self.quad
    t.map = d.map
    t.image = self.image
    t.z = 0
    t.code = "G0"
    function t:_draw()
    end
    function t:_batch()
      if self.parent.spritebatch ~= nil then
        local code = ""
        local val = self.map[self.x][self.y]

        if self.map[self.x][self.y - 1] == val then
          code = code .. "N"
        end
        if self.map[self.x][self.y + 1] == val then
          code = code .. "S"
        end
        if self.map[self.x + 1] ~= nil and self.map[self.x + 1][self.y] == val then
          code = code .. "E"
        end
        if self.map[self.x - 1] ~= nil and self.map[self.x - 1][self.y] == val then
          code = code .. "W"
        end

        self.parent.spritebatch:add(self.quad["W1"][code], self.l, self.t, 0, self.w / 16, self.h / 16)
      end
    end
    return t 
  end
  return gen 
end
main()
