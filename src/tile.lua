function _tile()
  local tile = {}
  function tile:create()
    local t = {}
    t.l = 0
    t.t = 0
    t.h = 0
    t.w = 0
    t.children = {}
    t.parent = {}
    return t
  end
  return tile
end
if __tile ~= nil then
  return __tile
else
  __tile = _thing()
  return __tile
end

