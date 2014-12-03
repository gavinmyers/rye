function _thing()
  local thing = {}
  function thing:create()
    local t = {}
    t.l = 0
    t.t = 0
    t.h = 0
    t.w = 0
    t.children = {}
    t.parent = {}
    return t
  end
  return thing
end
if __thing ~= nil then
  return __thing
else
  __thing = _thing()
  return __thing
end

