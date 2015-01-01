local map = require 'com.engine.map'
local function main()
  local gen = map:create("SIMPLE")
  function gen:_new(d)
    local t = map:create("SIMPLE-"..math.random(1000,9999).."-"..math.random(1000,9999))
    t.code = "S0"
    t.width = d.width
    t.height = d.height
    t.generation = {} 
    for x=1,d.width do
      t.generation[x]={}
      for y=1,d.height do
        if x == 1 or y == 1 or x == t.width or y == t.height then
          t.generation[x][y]=1
        else
          t.generation[x][y]=255
        end
      end
    end
    t.generation[2][2] = 100
    t.generation[t.width - 1][t.height - 1] = 100
    return t 
  end
end
main()
