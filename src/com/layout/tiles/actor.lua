local tile = require 'com.layout.tile'
local function main()
  local gen = tile:create("ACTOR")
  gen.image = love.graphics.newImage("com/style/ULPCSS/spritesheet_1.png")
  gen.image:setFilter("nearest")
  gen.quad = {}
  gen.quad["WALK"] = {
    love.graphics.newQuad(64 * 0, 64 * 11, 64, 64, 1536, 2112)
    ,love.graphics.newQuad(64 * 1, 64 * 11, 64, 64, 1536, 2112)
    ,love.graphics.newQuad(64 * 2, 64 * 11, 64, 64, 1536, 2112)
    ,love.graphics.newQuad(64 * 3, 64 * 11, 64, 64, 1536, 2112)
    ,love.graphics.newQuad(64 * 4, 64 * 11, 64, 64, 1536, 2112)
    ,love.graphics.newQuad(64 * 5, 64 * 11, 64, 64, 1536, 2112)
    ,love.graphics.newQuad(64 * 6, 64 * 11, 64, 64, 1536, 2112)
    ,love.graphics.newQuad(64 * 7, 64 * 11, 64, 64, 1536, 2112)
    ,love.graphics.newQuad(64 * 8, 64 * 11, 64, 64, 1536, 2112)
  }
  function gen:_new()
    local t = tile:create("ACTOR-"..math.random(1000,9999).."-"..math.random(1000,9999))
    t.last_updated = 0 
    t.last_quad = nil
    t.last_counter = 1 
    t.z = 1
    t.speed = 80
    t.code = "A0"
    function t:_draw()
      local time = os.clock()
      if (time - self.last_updated) > 0.01 then
        self.last_counter = self.last_counter + 1
        if self.last_counter > 8 then
          self.last_counter = 1 
        end
        local last_quad = self.parent.quad["WALK"][self.last_counter]
        self.last_quad = last_quad
        self.last_updated = time
      end
      love.graphics.draw(self.parent.image,self.last_quad,self.l, self.t, 0, self.w / 64, self.h / 64)

      --love.graphics.rectangle("fill",self.l + (self.w / 2), self.t + (self.h / 2), self.w / 4, self.h / 4 )
    end
    return t 
  end
  return gen 
end
main()
