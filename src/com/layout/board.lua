local function _board()
  local board = {}
  function board:version() 
    print("v1.0.0")
  end
  function board:load()
  end
  function board:create(id)
    local t = {}
    t.id = id
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
