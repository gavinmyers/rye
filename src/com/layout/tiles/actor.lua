local tile = require 'com.layout.tile'
local function main()
  local gen = tile:create("ACTOR")
  function gen:_new()
    local t = tile:create("ACTOR-"..math.random(1000,9999).."-"..math.random(1000,9999))
    t.z = 1
    t.code = "A0"
    function t:_draw()
      love.graphics.setColor(math.random(1,255),math.random(1,255),math.random(1,255))
      love.graphics.rectangle("fill",self.l,self.t,self.w,self.h)
    end
    return t 
  end
  return gen 
end
main()
