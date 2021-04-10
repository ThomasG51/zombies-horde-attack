function playUpdate(dt)
  
  for i=#zombiesList, 1, -1 do
    -- Zombies animations
    zombiesList[i].animation(dt)
    
    --Zombies state
    zombiesList[i].mode(dt)
  end
  
  -- Survivor deplacement
  survivor.walking(dt)
  
end
