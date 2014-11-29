local bump = require 'lib/bump'
local shader = require 'lib/postshader'
local light = require 'lib/light'
local thing = require 'thing'

local instructions = [[
  bump.lua simple demo

    arrows: move
    tab: toggle debug info
    delete: run garbage collector
]]
-- Block functions
local blocks = {}
-- Eaters 
local blockEaters = {}
-- World creation
local world = bump.newWorld()

-- helper function
local function drawBox(box, r,g,b)
  love.graphics.setColor(r,g,b,70)
  love.graphics.rectangle("fill", box.l, box.t, box.w, box.h)
  love.graphics.setColor(r,g,b)
  love.graphics.rectangle("line", box.l, box.t, box.w, box.h)
end

local function moveBlock(block,dx,dy)
  if dx ~= 0 or dy ~= 0 then
    local future_l, future_t = block.l + dx, block.t + dy
    local cols, len = world:check(block, future_l, future_t)
    if len == 0 then
      block.l, block.t = future_l, future_t
      world:move(block, future_l, future_t)
    else
      local col, tl, tt, sl, st
      while len > 0 do
        col = cols[1]
        tl,tt,_,_,sl,st = col:getSlide()
        block.l, block.t = tl, tt
        world:move(block, tl, tt)
        cols, len = world:check(block, sl, st)
        if len == 0 then
          block.l, block.t = sl, st
          world:move(block, sl, st)
        end
      end
    end
  end
end

local function wiggleBlocks(dt) 
  for i,block in pairs(blocks) do
    local dx, dy = 0, 0
    local speed = block.speed
    if math.random(1,6) == 1 then 
      dx = speed * dt
    elseif math.random(1,6) == 1 then 
      dx = -speed * dt
    end
    if math.random(1,6) == 1 then 
      dy = speed * dt
    elseif math.random(1,6) == 1 then 
      dy = -speed * dt
    end
    moveBlock(block,dx,dy)
  end
  for i,block in pairs(blockEaters) do
    local dx, dy = 0, 0
    local speed = block.speed
    if math.random(1,6) == 1 then 
      dx = speed * dt
    elseif math.random(1,6) == 1 then 
      dx = -speed * dt
    end
    if math.random(1,6) == 1 then 
      dy = speed * dt
    elseif math.random(1,6) == 1 then 
      dy = -speed * dt
    end
    local future_l, future_t = block.l + dx, block.t + dy
    local collisions, len = world:check(block,future_l,future_t)
    for _,col in ipairs(collisions) do 
      if col.other.name == "wall" then
        blocks[col.other.id] = nil
        world:remove(col.other)
      end
    end
    if blockEaters[block.id] ~= nil then
      moveBlock(block,dx,dy)
    end
  end

end

local function addBlock(l,t,w,h)
  local id = tostring(math.random())
  local block = {l=l,t=t,w=w,h=h,speed=120,name="wall",id=id}
  blocks[block.id] = block
  world:add(block, l,t,w,h)
end
local function addBlockEater(l,t,w,h)
  local id = tostring(math.random())
  local block = {l=l,t=t,w=w,h=h,speed=120,name="eater",id=id}
  blockEaters[id] = block
  world:add(block, l,t,w,h)
end



-- Player functions
local player = { l=50,t=50,w=20,h=20, speed = 120,name="player"}

local function updatePlayer(dt)
  local speed = player.speed

  local dx, dy = 0, 0
  if love.keyboard.isDown('right') then
    dx = speed * dt
  elseif love.keyboard.isDown('left') then
    dx = -speed * dt
  end
  if love.keyboard.isDown('down') then
    dy = speed * dt
  elseif love.keyboard.isDown('up') then
    dy = -speed * dt
  end
  moveBlock(player,dx,dy)
  wiggleBlocks(dt)
end

local function drawPlayer()
  drawBox(player, 0, 255, 0)
end


local function drawBlocks()
  for _,block in pairs(blocks) do
    drawBox(block, 255,0,0)
  end
end
local function drawBlockEaters()
  for _,block in pairs(blockEaters) do
    drawBox(block, 255,255,0)
  end
end


-- Message/debug functions
local function drawMessage()
  local msg = instructions:format(tostring(shouldDrawDebug))
  love.graphics.setColor(255, 255, 255)
  love.graphics.print(msg, 550, 10)
end

local function drawDebug()

  local statistics = ("fps: %d, mem: %dKB"):format(love.timer.getFPS(), collectgarbage("count"))
  love.graphics.setColor(255, 255, 255)
  love.graphics.print(statistics, 630, 580 )
end


function love.load()
  world:add(player, player.l, player.t, player.w, player.h)

  addBlock(0,       0,     800, 32)
  addBlock(0,      32,      32, 600-32*2)
  addBlock(800-32, 32,      32, 600-32*2)
  addBlock(0,      600-32, 800, 32)

  for i=1,10 do
    addBlock( math.random(100, 600),
              math.random(100, 400),
              math.random(10, 10),
              math.random(10, 10)
    )
  end
end

-- Non-player keypresses
function love.keypressed(k)
  if k=="escape" then love.event.quit() end
  if k=="tab"    then shouldDrawDebug = not shouldDrawDebug end
  if k=="delete" then collectgarbage("collect") end
  if k==" " then 
    addBlockEater( math.random(100, 600),
              math.random(100, 400),
              math.random(3, 5),
              math.random(3, 5)
    )
  end
end

function love.update(dt)
  updatePlayer(dt)
end

local lightWorld = love.light.newWorld() 
local lightMouse = lightWorld.newLight(255,255,255,255,255,300) 
function initLight() 
  lightWorld.clearBodys()
  for _,box in pairs(blocks) do
    local r = lightWorld.newRectangle(box.l, box.t, box.w, box.h)
  end
 for _,box in pairs(blockEaters) do
    local r = lightWorld.newRectangle(box.l, box.t, box.w, box.h)
  end

end
function drawLight()
  lightWorld.update()
  lightWorld.drawShadow()
end
function love.draw()
  love.graphics.setColor(255,255,255,70)
  love.graphics.rectangle("fill",0,0,1024,768) 
  love.graphics.setColor(100,100,100)
  love.graphics.rectangle("line",0,0,1024,768) 

  initLight()
  drawBlocks()
  drawBlockEaters()
  drawPlayer()
  if shouldDrawDebug then drawDebug() end
  drawMessage()
  lightMouse.setPosition(player.l, player.t)
  drawLight()
end


