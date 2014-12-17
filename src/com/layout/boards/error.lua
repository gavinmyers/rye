local board = require 'com.layout.board'

local function main()
  local gen = board:create("ERROR")

  function gen:_new()
    local b = board:create("ERROR-"..math.random(1000,9999).."-"..math.random(1000,9999))

    function b:_draw()
      love.graphics.setColor(255, 255, 255)
      local screenWidth, screenHeight = love.window.getDimensions()
    love.graphics.printf("Unable to generate board, I'm not sure why. Sorry. :(", 0, 1, screenWidth, "center")

    end

    function b:_keypressed(k)
      love.event.quit() 
    end
    return b
  end

  return gen
end
main()
