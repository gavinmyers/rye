local map = require 'com.engine.map'
local function main()
  local gen = map:create("CAVE")
  function gen:_new()
    local t = map:create("CAVE-"..math.random(1000,9999).."-"..math.random(1000,9999))
    t.code = "C0"
    return t 
  end
  return gen 
end
main()
