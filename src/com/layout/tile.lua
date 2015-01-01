local function _tile()
  local tile = {}
  tile.db = {}
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
    t.z = 0
    t.w = 4 
    t.h = 4 
    t.speed = 80
    t.code = "TILE"

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

