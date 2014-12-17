local function _map()
  local map = {}
  map.db = {}
  function map:load()
  end
  function map:get(id)
    return self.db[id]
  end
  function map:new(id)
    return self:get(id):new()
  end
  function map:create(id)
    local t = {}
    t.id = id
    t.code = "MAP"

    function t:new()
      if self._new ~= nil then
        return self:_new()
      end
    end

    map.db[id] = t
    return t
  end
  return map
end

if __map ~= nil then
  return __map
else
  __map = _map()
  return __map
end

