local tile = require 'com.layout.tile'
local function main()
  local gen = tile:create("ACTOR")
  gen.image = love.graphics.newImage("com/style/DawnLike_1/Characters/Player0.png")
  gen.image:setFilter("nearest")
  gen.quad = {}
  gen.quad["P1"] = love.graphics.newQuad(16, 48, 16, 16, 128, 224)
  function gen:_new()
    local t = tile:create("ACTOR-"..math.random(1000,9999).."-"..math.random(1000,9999))
    t.z = 1
    t.speed = 80
    t.code = "A0"
    function t:_draw()
      love.graphics.draw(self.parent.image,self.parent.quad["P1"], self.l, self.t, 0, self.w / 16, self.h / 16)
    end
    return t 
  end
  return gen 
end
main()
