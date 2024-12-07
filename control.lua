require "gui"

function tp()
 local player1 = nil
 for _, e in pairs(game.players) do
  if e.valid and e.name == 'Kin_Chen' then
   player1 = e
  end
 end 
 if player1 ~= nil then 
  local select = player1.selected
  if select ~= nil then
   local newpos = {x=select.position.x, y=select.position.y}
   player1.teleport(newpos, select.surface_index)
   player1.surface.create_entity{name="my-fire", position=player1.position, force="player"}
  end
 end
end
script.on_event("my-custom-input", function(event)
    tp()
end)