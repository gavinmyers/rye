local board = require 'com.layout.board'
local map = require 'com.engine.map'
--local engine = require 'com.layout.board'
--local style = require 'com.layout.board'

local function _rye()
  local rye = {}
  function rye:new()
    local r = {}
    local map = map:new("SIMPLE",{width=132,height=98})
    r.board = board:new("GAME", {map=map.generation})
    --r.engine = engine:new("GAME")
    --r.style = style:new("GAME")

    function r:draw()
      r.board:draw()
    end

    function r:update(dt)
      r.board:update(dt)
    end

    function r:keypressed(k)
      --r.map = map:new("CAVE",{width=r.width,height=r.height})
      --r.board = board:new("GAME", {map=r.map})
      r.board:keypressed(k)
    end

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
