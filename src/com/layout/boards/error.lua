local board = require 'com.layout.board'
local function main()
  local b = board:create("ERROR")
  function b:_draw()
    love.graphics.setColor(255, 255, 255)
    local screenWidth, screenHeight = love.window.getDimensions()
  love.graphics.printf("Unable to generate board, I'm not sure why. Sorry. :(", 0, 1, screenWidth, "center")

  end

  function b:_keypressed(k)
    love.event.quit() 
  end
end
main()
