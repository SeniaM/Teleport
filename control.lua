require "gui"
require "helpFuncs"
  
script.on_event("my-custom-input", function(event)
    local player = game.get_player(event.player_index)
    local selected
    
    if player.valid and player ~= nil then
      selected = player.selected
    end
    if selected ~= nil then
      local newpos = {x=selected.position.x, y=selected.position.y}
      tp(player, newpos, selected.surface_index)
    else
      mainMenu(event)
      for i, v in pairs(game.players) do
        if v.character then
          game.print(v.name)
        end
      end
      
    end
end)