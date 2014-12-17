require 'lib.require'

local global_lock = require 'lib.global_lock'
local bump = require 'lib.bump'
local shader = require 'lib.postshader'
local light = require 'lib.light'
local board = require 'com.layout.board'

local maps = require.tree('com.engine.maps')
local things = require.tree('com.engine.things')
local tiles = require.tree('com.layout.tiles')
local boards = require.tree('com.layout.boards')

local welcome = board:new("GAME") 
function love.load()
end

function love.keypressed(k)
  welcome:keypressed(k)
end

function love.update(dt)
  welcome:update(dt)
end

function love.draw()
  welcome:draw()
end


