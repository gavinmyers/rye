local function _rye()
  local rye = {}
  function rye:new()
    local r = {}
    r.board = board:get("GAME")
    r.engine = engine:get("GAME")
    r.style = style:get("GAME")
    r.map = map:new("CAVE")
    return r
  end
  return rye
end

if __rye ~= nil then
  return __rye
else
  __rye = _rye()
  return __rye
end
