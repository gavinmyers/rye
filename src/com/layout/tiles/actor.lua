local tile = require 'com.layout.tile'
local function main()
  local gen = tile:create("ACTOR")
  function gen:_new()
    local t = tile:create("ACTOR-"..math.random(1000,9999).."-"..math.random(1000,9999))
    function t:_draw()
      love.graphics.setColor(0,255,255)
      love.graphics.rectangle("fill",self.l,self.t,self.w,self.h)
    end
    return t 
  end
  return gen 
end
main()
