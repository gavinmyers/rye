local tile = require 'com.layout.tile'
local anim8 = require 'lib.anim8'
local function main()
  local gen = tile:create("ACTOR")
  gen.image = love.graphics.newImage("com/style/ULPCSS/spritesheet_1.png")
  gen.anim8 = anim8.newGrid(64,64, 1536,2112,   0,0,     0)
  gen.quad = {}
  gen.quad["WALK_N"] = anim8.newAnimation(gen.anim8('1-9',9),0.1) 
  gen.quad["WALK_W"] = anim8.newAnimation(gen.anim8('1-9',10),0.1) 
  gen.quad["WALK_S"] = anim8.newAnimation(gen.anim8('1-9',11),0.1) 
  gen.quad["WALK_E"] = anim8.newAnimation(gen.anim8('1-9',12),0.1) 
 
  function gen:_new()
    local t = tile:create("ACTOR-"..math.random(1000,9999).."-"..math.random(1000,9999))
    t.direction = "W"
    t.last_updated = 0 
    t.last_quad = nil
    t.last_counter = 1 
    t.z = 1
    t.speed = 80
    t.code = "A0"
    function t:_update(dt)
      gen.quad["WALK_"..self.direction]:update(dt)
    end
    function t:_draw()
      love.graphics.setColor(10,10,10)
      love.graphics.rectangle("fill",self.l, self.t, 6, 6) 
      love.graphics.setColor(255,255,255)
      gen.quad["WALK_"..self.direction]:draw(gen.image, self.l, self.t)
    end
    return t 
  end
  return gen 
end
main()
