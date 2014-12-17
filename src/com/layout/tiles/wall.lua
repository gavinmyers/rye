local tile = require 'com.layout.tile'
local function main()
  local gen = tile:create("WALL")
  function gen:_new()
    local t = tile:create("WALL-"..math.random(1000,9999).."-"..math.random(1000,9999))
    t.z = 2
    t.code = "W0"
    function t:_draw()
      love.graphics.setColor(0,0,0)
      love.graphics.rectangle("fill",self.l,self.t,self.w,self.h)
    end
    return t 
  end
  return gen 
end
main()
