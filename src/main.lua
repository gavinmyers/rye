local global_lock = require 'lib/global_lock'
local bump = require 'lib/bump'
local shader = require 'lib/postshader'
local light = require 'lib/light'

local thing = require 'com/thing'

function love.load()
  thing.version()
end

function love.keypressed(k)
  if k=="escape" then love.event.quit() end
end

function love.update(dt)
end

function love.draw()
  love.graphics.setColor(0,255,255)
  love.graphics.rectangle("fill",0,0,16,16) 
end


