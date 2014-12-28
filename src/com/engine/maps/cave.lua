local map = require 'com.engine.map'
local function main()
  local gen = map:create("CAVE")
  function gen:_new(d)
    local t = map:create("CAVE-"..math.random(1000,9999).."-"..math.random(1000,9999))

    function t:avg(a) 
      local sum = 0
      local avg = 0
      for k,v in pairs(a) do
        if v ~= nil then
          sum = sum + v
          avg = avg + 1
        end
      end
      return sum / avg 
    end

    function t:val(x,y) 
      if x < 1 then
        return nil
      end
      if y < 1 then
        return nil
      end
      if x > self.width then
        return nil
      end
      if y > self.height then 
        return nil
      end
      return self.generation[x][y] 
    end

    t.code = "C0"
    t.width = d.width
    t.height = d.height
    local m = {}
    for x=1,d.width do
      m[x]={}
      for y=1,d.height do
        m[x][y]=math.random(255)
      end
    end
    t.generation = m
    for i=1,2 do
      for x=1,d.width do
        for y=1,d.height do
          local a = {t:val(x-1,y-1),
                      t:val(x-1,y),
                      t:val(x-1,y+1),
                      t:val(x,y-1),
                      t:val(x,y),
                      t:val(x,y+1),
                      t:val(x+1,y-1),
                      t:val(x+1,y),
                      t:val(x+1,y+1)}
          t.generation[x][y] = t:avg(a)
        end
      end
    end
    return t 
  end
  return gen 
end
main()
