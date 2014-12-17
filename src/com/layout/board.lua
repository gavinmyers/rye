local function _board()
  local board = {}
  board.db = {} 
  function board:load()
  end
  function board:new(id)
    return self:get(id):new()
  end
  function board:get(id)
    return self.db[id]
  end

  function board:create(id)
    local t = {}
    t.id = id
    t.db = {}
    function t:draw()
      if self._draw ~= nil then
        self:_draw()
      else
        print("NO DRAWING TOOL FOR THIS BOARD")
        love.event.quit()
      end
    end

    function t:add(tile) 
      if self.db[tile.z] == nil then
        self.db[tile.z] = {}
      end
      self.db[tile.z][tile.id] = tile
      return self.db[tile.z][tile.id]
    end
    function t:get(id) 
      if id ~= nil then
        for k, v in pairs(self:get()) do
          if v[id] ~= nil then
            return v[id]
          end
        end
      else
        return self.db
      end
    end
    function t:new()
      if self._new ~= nil then
        return self:_new()
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
