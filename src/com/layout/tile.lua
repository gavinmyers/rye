local function _tile()
  local tile = {}
  tile.db = {}
  function tile:load()
  end
  function tile:get(id)
    return self.db[id]
  end
  function tile:new(id,d)
    return self:get(id):new(d)
  end

  function tile:create(id)
    local t = {}
    t.id = id
    t.l = 0
    t.t = 0
    t.z = 0
    t.w = 4 
    t.h = 4 
    t.x = 0
    t.y = 0
    t.code = "TILE"
    t.spritebatch = nil

    function t:update(dt)
      if self._update ~= nil then
        return self:_update(dt)
      end
    end

    
    function t:draw()
      if self._draw ~= nil then
        return self:_draw()
      else
        print("NO DRAWING TOOL FOR THIS TILE")
        love.event.quit()
      end
    end

    function t:batch()
      if self._batch ~= nil then
        return self:_batch()
      end
      return nil
    end

    function t:new(d)
      if self._new ~= nil then
        local tile = self:_new(d)
        tile.parent = self
        return tile
      else
        print("NO CONSTRUCTOR FOR THIS TILE")
        love.event.quit()
      end
    end


    tile.db[id] = t
    return t
  end
  return tile
end

if __tile ~= nil then
  return __tile
else
  __tile = _tile()
  return __tile
end

