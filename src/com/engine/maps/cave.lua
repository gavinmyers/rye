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

    function t:valid(x,y)
      if x < 1 then
        return false 
      end
      if y < 1 then
        return false 
      end
      if x > self.width then
        return false 
      end
      if y > self.height then 
        return false 
      end
      return true
    end

    function t:square(t,l,w,h,v)
      for x=t,t+w do
        for y=l,l+h do
          if self:valid(x,y) then
            self.generation[x][y] = v 
          end
        end
      end
    end

    function t:val(x,y) 
      if self:valid(x,y) then
        return self.generation[x][y] 
      end
    end

    t.code = "C0"
    t.width = d.width
    t.height = d.height
    t.generation = {} 
    for x=1,d.width do
      t.generation[x]={}
      for y=1,d.height do
        t.generation[x][y]=math.random(255)
      end
    end

    for k=1,5 do
      for x=1,d.width do
        for y=1,d.height do
          t.generation[x][y]= math.min(255, t.generation[x][y] / 2 + math.random(t.generation[x][y]))
        end
      end

      for i=1,35 do
        t:square(math.random(t.width),math.random(t.height),math.random(t.width / 8), math.random(t.height / 8), 255)
      end
      for i=1,25 do
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

      for i=1,5 do
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
            if t:avg(a) > t.generation[x][y] then
              t.generation[x][y] = t:avg(a)
            end
          end
        end
      end
    end
    for x=1,d.width do
      for y=1,d.height do
        if t.generation[x][y] > 240 then
          --t.generation[x][y] = 255
        elseif t.generation[x][y] > 220 then
          --t.generation[x][y] = 254
        elseif t.generation[x][y] > 200 then
          --t.generation[x][y] = 253
        elseif t.generation[x][y] > 180 then
          --t.generation[x][y] = 252
        else
          --t.generation[x][y] = 1 
        end
          --t.generation[x][y] = math.floor(t.generation[x][y] * 0.8) 
      end
    end

    return t 
  end
  return gen 
end
main()
