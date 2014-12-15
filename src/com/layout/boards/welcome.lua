local board = require 'com.layout.board'
local function main()
  local b = board:create("WELCOME")
  function b:_draw()
    love.graphics.setColor(255, 255, 255)
    local screenWidth, screenHeight = love.window.getDimensions()
    love.graphics.printf("\n******************\n   WELCOME TO LOAF \n******************\n\n [1] TUTORIAL \n\n [2] CONTINUE \n\n [X] QUIT", 0, 1, screenWidth, "center")

    love.graphics.setColor(0,255,255)
    love.graphics.rectangle("fill",0,0,16,16) 
  end

  function b:_keypressed(k)
    if k=="escape" then 
      love.event.quit() 
    elseif k == "1" then 
      board:current("GAME") 
    end
  end
end
main()
