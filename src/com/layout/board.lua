local function _board()
  local board = {}
  board.db = {} 
  board.currentBoard = nil
  function board:version() 
    print("v1.0.0")
  end
  function board:load()
  end
  function board:keypressed(k)
    self:current():keypressed(k)
  end
  function board:update(dt)
    self:current():update(dt)
  end
  function board:draw()
    self:current():draw()
  end
  function board:current(id)
    if id ~= nil then
      board.currentBoard = board.db[id]
    end
    return board.currentBoard
  end
  function board:create(id)
    local t = {}
    t.id = id
    function t:draw()
      if self._draw ~= nil then
        self:_draw()
      else
        print("NO DRAWING TOOL FOR THIS BOARD")
        love.event.quit()
      end
    end

    function t:update(dt)
      if self._update ~= nil then
        self:_update(dt)
      end
    end

    function t:keypressed(k)
      if self._keypressed ~= nil then
        self:_keypressed(k)
      else
        if k=="escape" then love.event.quit() end
      end
    end

    board.db[id] = t
    return t
  end
  return board
end

if __board ~= nil then
  return __board
else
  __board = _board()
  return __board
end
