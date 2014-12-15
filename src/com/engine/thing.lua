local function _thing()
  local thing = {}
  function thing:version() 
    print("v1.0.0")
  end
  function thing:load()
  end
  function thing:create()
    local t = {}
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
