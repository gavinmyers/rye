local function _tile()
  local tile = {}
  tile.db = {}

  function tile:version() 
    print("v1.0.0")
  end
  function tile:load()
  end
  function tile:get(id)
    return self.db[id]
  end
  function tile:new(id)
    return self:get(id):new()
  end
  function tile:create(id)
    local t = {}
    t.id = id
    t.l = 0
    t.t = 0
    t.w = 16
    t.h = 16
    t.speed = 80

    function t:draw()
      if self._draw ~= nil then
        return self:_draw()
      else
        print("NO DRAWING TOOL FOR THIS TILE")
        love.event.quit()
      end
    end

    function t:new()
      if self._new ~= nil then
        return self:_new()
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

