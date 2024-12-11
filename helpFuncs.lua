function tp(player, pos, surface_index)
  local freepos = player.surface.find_non_colliding_position("character", pos, 0, 0.01)
  player.teleport(freepos, surface_index)
  runFx(player)
end

function runFx(player) 
  player.surface.create_entity{name="my-fire", position=player.position, force="player"}
end