-- display logs in console during execution
io.stdout:setvbuf('no')

-- Pixel Art mode
love.graphics.setDefaultFilter("nearest")

love.window.setMode(1280, 800)
love.window.setTitle('Zombies Attack')

WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()

DEBUG_MODE = false

STATE_MACHINE = {}
STATE_MACHINE.NONE = "none"
STATE_MACHINE.WALK = "walk"
STATE_MACHINE.HUNT = "hunt"
STATE_MACHINE.BITE = "bite"
STATE_MACHINE.CHOOSE_DIRECTION = "choose_direction"

require('functions/maths')
require('functions/makeZombie')
require('modes/play/playUpdate')
require('modes/play/playDraw')

gameMode = 'play'

survivor = require('entities/survivor')
zombiesList = {}

function love.load()
  -- create zombies horde
  for i=1,40 do
    makeZombie(math.random(140, 1140), math.random(20, 480))
  end
end

function love.update(dt)
  if gameMode == 'menu' then
    
  elseif gameMode == 'play' then
    playUpdate(dt)
    
  elseif gameMode == 'pause' then
    
  elseif gameMode == 'gameover' then
    
  end
end

function love.draw()
  if gameMode == 'menu' then
    
  elseif gameMode == 'play' then
    playDraw()
    
  elseif gameMode == 'pause' then
    
  elseif gameMode == 'gameover' then
    
  end
end

function love.keypressed(key)
  if gameMode == 'menu' then
    
  elseif gameMode == 'play' then
    if key == 'd' then
      DEBUG_MODE = true
    end

  elseif gameMode == 'pause' then
    
  elseif gameMode == 'gameover' then
    
  end
end