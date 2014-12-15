local tile = require 'com.layout.tile'
local function main()
  local t = tile:create("ACTOR")
  function t:_draw()
    love.graphics.setColor(0,255,255)
    love.graphics.rectangle("fill",self.l,self.t,self.w,self.h)
  end
  return t 
end
main()
