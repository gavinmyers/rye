local tile = require 'com.layout.tile'
local function main()
  local gen = tile:create("GROUND")
  gen.image = love.graphics.newImage("com/style/DawnLike_1/Objects/Wall.png")
  gen.quad = love.graphics.newQuad(64, 16, 16, 16, 320, 816)
  gen.spritebatch = love.graphics.newSpriteBatch(gen.image,100000)

  function gen:_draw()
    love.graphics.draw(self.spritebatch)
  end

  function gen:_new()
    local t = tile:create("GROUND-"..math.random(1000,9999).."-"..math.random(1000,9999))
    t.quad = self.quad
    t.image = self.image
    t.z = 0
    t.code = "G0"
    function t:_draw()
      if self.parent.spritebatch == nil then
        love.graphics.setColor(225,225,225)
        love.graphics.rectangle("fill",self.l,self.t,self.w,self.h)
        love.graphics.draw(self.image, self.quad, self.l, self.t, 0, self.w / 16, self.h / 16)
      end
    end
    function t:_batch()
      if self.parent.spritebatch ~= nil then
        self.parent.spritebatch:add(self.quad, self.l, self.t, 0, self.w / 16, self.h / 16)
      end
    end
    return t 
  end
  return gen 
end
main()
