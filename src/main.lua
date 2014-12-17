require 'lib.require'

local global_lock = require 'lib.global_lock'
local bump = require 'lib.bump'
local shader = require 'lib.postshader'
local light = require 'lib.light'
local rye = require 'com.rye'

local maps = require.tree('com.engine.maps')
local things = require.tree('com.engine.things')
local tiles = require.tree('com.layout.tiles')
local boards = require.tree('com.layout.boards')

local rye = rye:new() 

function love.load()
end

function love.keypressed(k)
  rye:keypressed(k)
end

function love.update(dt)
  rye:update(dt)
end

function love.draw()
  rye:draw()
end


