local survivor = {}
survivor.sprites = {}
survivor.sprites[1] = love.graphics.newImage('assets/images/player_1.png')
survivor.sprites[2] = love.graphics.newImage('assets/images/player_2.png')
survivor.sprites[3] = love.graphics.newImage('assets/images/player_3.png')
survivor.sprites[4] = love.graphics.newImage('assets/images/player_4.png')
survivor.sprites[5] = love.graphics.newImage('assets/images/dead_1.png')
survivor.activeSprite = 1
survivor.width = survivor.sprites[1]:getWidth()
survivor.height = survivor.sprites[1]:getHeight()
survivor.positionX = WINDOW_WIDTH / 2
survivor.positionY = 740
survivor.originX = survivor.width / 2
survivor.originY = survivor.height / 2
survivor.speed = 100
survivor.health = 100
survivor.dead = false

survivor.animation = function(dt)
  survivor.activeSprite = survivor.activeSprite + (8 * dt)
  if survivor.activeSprite > 5 then
    survivor.activeSprite = 1
  end
end

survivor.walking = function(dt)

  if survivor.dead == false then
    if love.keyboard.isDown('up','right','down','left') then    
      survivor.animation(dt)

      if love.keyboard.isDown('up') and (survivor.positionY - survivor.height) >= 0 then
        survivor.positionY = survivor.positionY - (survivor.speed * dt)
      end
      
      if love.keyboard.isDown('right') and survivor.positionX <= WINDOW_WIDTH then
        survivor.positionX = survivor.positionX + (survivor.speed * dt)
      end
      
      if love.keyboard.isDown('down') and (survivor.positionY + survivor.height) <= WINDOW_HEIGHT then
        survivor.positionY = survivor.positionY + (survivor.speed * dt)
      end
      
      if love.keyboard.isDown('left') and survivor.positionX >= 0 then
        survivor.positionX = survivor.positionX - (survivor.speed * dt)
      end
    end
  end
end

survivor.attacked = function()
  survivor.health = survivor.health - 0.1
  
  if survivor.health <= 0 then
    survivor.health = 0
    
    survivor.dead = true
  end
end

return survivor