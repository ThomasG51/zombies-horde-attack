function playDraw()

  -- survivor
  if survivor.dead == false then
    love.graphics.draw(survivor.sprites[math.floor(survivor.activeSprite)], survivor.positionX, survivor.positionY, 0, 3, 3, survivor.originX, survivor.originY)
  else
    love.graphics.draw(survivor.sprites[5], survivor.positionX, survivor.positionY, 0, 3, 3, survivor.originX, survivor.originY)
  end
  
  love.graphics.print('HP: '..math.floor(survivor.health), 10, 10)

  -- zombies
  for i=#zombiesList, 1, -1 do
    love.graphics.draw(zombiesList[i].sprites[math.floor(zombiesList[i].activeSprite)], zombiesList[i].positionX, zombiesList[i].positionY, 0, 3, 3, zombiesList[i].originX, zombiesList[i].originY)
    
    if zombiesList[i].state == 'hunt' then
      love.graphics.draw(zombiesList[i].alert, zombiesList[i].positionX, zombiesList[i].positionY-zombiesList[i].height, 0, 2, 2, zombiesList[i].originX, zombiesList[i].originY)
    end
  end
  
  if survivor.dead == true then
    love.graphics.print("YOU'RE DEAD", 10, 30, 0, 4, 4)
  end

  --debug mode
  if DEBUG_MODE == true then
    for i=#zombiesList, 1, -1 do
      love.graphics.print(zombiesList[i].state, zombiesList[i].positionX - 15, (zombiesList[i].positionY - zombiesList[i].height) - 25)
    end
  end
end