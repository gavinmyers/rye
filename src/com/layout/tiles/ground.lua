local tile = require 'com.layout.tile'
local function main()
  local gen = tile:create("GROUND")
  function gen:_new()
    local t = tile:create("GROUND-"..math.random(1000,9999).."-"..math.random(1000,9999))
    function t:_draw()
      t.z = 0
      t.code = "G0"
      love.graphics.setColor(0,0,0)
      love.graphics.rectangle("fill",self.l,self.t,self.w,self.h)
    end
    return t 
  end
  return gen 
end
main()
