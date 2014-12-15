require 'lib.require'

local global_lock = require 'lib.global_lock'
local bump = require 'lib.bump'
local shader = require 'lib.postshader'
local light = require 'lib.light'

local board = require 'com.layout.board'
local boards = require.tree('com.layout.boards')

function love.load()
  board:load()
  board:current("WELCOME")
end

function love.keypressed(k)
  board:keypressed(k)
end

function love.update(dt)
  board:update(dt)
end

function love.draw()
  board:draw()
end


