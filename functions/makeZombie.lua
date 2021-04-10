function makeZombie(x, y)

  local zombie = {}
  zombie.sprites = {}
  zombie.sprites[1] = love.graphics.newImage('assets/images/monster_1.png')
  zombie.sprites[2] = love.graphics.newImage('assets/images/monster_2.png')
  zombie.activeSprite = math.random(1,2)
  zombie.width = zombie.sprites[1]:getWidth()
  zombie.height = zombie.sprites[1]:getHeight()
  zombie.positionX = x
  zombie.positionY = y
  zombie.velocityX = 0
  zombie.velocityY = 0
  zombie.originX = zombie.width / 2
  zombie.originY = zombie.height / 2
  zombie.state = "none"
  zombie.detection = math.random(20, 200)
  zombie.alert = love.graphics.newImage('assets/images/alert.png')
  
  zombie.animation = function(dt)
    zombie.activeSprite = zombie.activeSprite + (math.random(2,4) * dt)
    if zombie.activeSprite > 3 then
      zombie.activeSprite = 1
    end
  end
  
  zombie.mode = function(dt)
    -- walking
    zombie.positionX = zombie.positionX + zombie.velocityX * dt
    zombie.positionY = zombie.positionY + zombie.velocityY * dt
    
    
    -- ========== --
    -- STATE NONE --
    -- ========== --
    if zombie.state == STATE_MACHINE.NONE then
      zombie.state = STATE_MACHINE.CHOOSE_DIRECTION
      
    -- ========== --
    -- STATE WALK --
    -- ========== --
    elseif zombie.state == STATE_MACHINE.WALK then
      -- borders collision
      if zombie.positionX < 0 then
        zombie.positionX  = 0
        zombie.state = STATE_MACHINE.CHOOSE_DIRECTION
      end
      if zombie.positionX > WINDOW_WIDTH then
        zombie.positionX  = WINDOW_WIDTH
        zombie.state = STATE_MACHINE.CHOOSE_DIRECTION
      end
      if zombie.positionY < 0 then
        zombie.positionY  = 0
        zombie.state = STATE_MACHINE.CHOOSE_DIRECTION
      end
      if zombie.positionY > WINDOW_HEIGHT then
        zombie.positionY  = WINDOW_HEIGHT
        zombie.state = STATE_MACHINE.CHOOSE_DIRECTION
      end
      
      -- Survivor detection
      if math.dist(zombie.positionX,zombie.positionY, survivor.positionX,survivor.positionY) <= zombie.detection and survivor.dead == false then
        zombie.state = STATE_MACHINE.HUNT
      end
      
    -- ========== --
    -- STATE HUNT --
    -- ========== --
    elseif zombie.state == STATE_MACHINE.HUNT then
      local target = math.angle(zombie.positionX, zombie.positionY, math.random(survivor.positionX-20, survivor.positionX+20), math.random(survivor.positionY-20, survivor.positionY+20))
      zombie.velocityX = (math.random(5, 50) / 100) * 2 * 60 * math.cos(target)
      zombie.velocityY = (math.random(5, 50) / 100) * 2 * 60 * math.sin(target)
      
      -- Bite survivor
      if math.dist(zombie.positionX,zombie.positionY, survivor.positionX,survivor.positionY) <= 5 then
        zombie.state = STATE_MACHINE.BITE
      end
      
      -- Survivor lost
      if math.floor(math.dist(zombie.positionX,zombie.positionY, survivor.positionX,survivor.positionY)) >= zombie.detection then
        zombie.state = STATE_MACHINE.WALK
      end
     
    -- ========== --
    -- STATE BITE --
    -- ========== --
    elseif zombie.state == STATE_MACHINE.BITE then
      zombie.velocityX = 0
      zombie.velocityY = 0
      
      survivor.attacked()
      
      if math.floor(math.dist(zombie.positionX,zombie.positionY, survivor.positionX,survivor.positionY)) > 5 then
        zombie.state = STATE_MACHINE.HUNT
      end
      
      if survivor.dead == true then
        zombie.state = STATE_MACHINE.CHOOSE_DIRECTION
      end
    
    -- ====================== --
    -- STATE CHOOSE DIRECTION --
    -- ====================== --
    elseif zombie.state == STATE_MACHINE.CHOOSE_DIRECTION then
      local direction = math.angle(zombie.positionX, zombie.positionY, math.random(0, WINDOW_WIDTH), math.random(0, WINDOW_HEIGHT))
      zombie.velocityX = (math.random(5, 50) / 100) * 60 * math.cos(direction)
      zombie.velocityY = (math.random(5, 50) / 100) * 60 * math.sin(direction)
      
      zombie.state = STATE_MACHINE.WALK
    end
  end
  
  table.insert(zombiesList, zombie)

end