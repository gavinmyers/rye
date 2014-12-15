local board = require 'com.layout.board'
local function main()
  print("time to make a board")
  local b = board:create("WELCOME")
  function b:_draw()
    love.graphics.setColor(0,255,255)
    love.graphics.rectangle("fill",0,0,16,16) 
  end
end
main()
