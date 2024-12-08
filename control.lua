require "gui"

function tp(player, selected)
   local newpos = {x=selected.position.x, y=selected.position.y}
   player.teleport(newpos, selected.surface_index)
   player.surface.create_entity{name="my-fire", position=player.position, force="player"}
end
  
script.on_event("my-custom-input", function(event)
    local player = game.get_player(event.player_index)
    local selected
    
    if player.valid and player ~= nil then
      selected = player.selected
    end
    if selected ~= nil then 
      tp(player, selected)
    else
      mainMenu(event)
    end
end)