require 'lib.require'

local global_lock = require 'lib.global_lock'
local bump = require 'lib.bump'
local shader = require 'lib.postshader'
local light = require 'lib.light'

local board = require 'com.layout.board'
local boards = require.tree('com.layout.boards')

function love.load()
  board:load()
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


