function mainMenu (event)
    if global == nil then global = {} end
    if global.players == nil then global.players = {{}} end
    
    local serialized_data = settings.global["coords-settings"].value
    
    global.players = loadstring("return " .. serialized_data)()
    if type(global.players) ~= "table" then
      global.players = {{}}
    end
    
  
  local player = game.get_player(event.player_index)
	local screen_element = player.gui.screen
  if player.gui.screen.ugg_main_frame then
    player.gui.screen.ugg_main_frame.destroy()
  end
	local main_frame = screen_element.add{type="frame", name="ugg_main_frame", caption={"test-mod.tp_menu"}}
	main_frame.style.width = 500
	main_frame.auto_center = true

  
	local content_frame = main_frame.add{type="frame", name="content_frame", direction="vertical", style="bordered_frame"}
  --content_frame.style.height = 560
	local controls_flow = content_frame.add{type="flow", name="controls_flow", direction="vertical"}
  controls_flow.style.vertical_spacing = 10
  local my_table = controls_flow.add{type="table", name = "my_table", column_count= 3}
  my_table.style.horizontal_spacing = 10
  my_table.style.top_margin = 20
  my_table.style.bottom_margin = 10
  local label1 = my_table.add{type="label", caption="Give a name for the new checkpoint:"}
  local empty_wid = my_table.add{type="empty-widget", style="draggable_space"}
  local empty_wid2 = my_table.add{type="empty-widget", style="draggable_space"}
  local textfield = my_table.add{type="textfield", name="ugg_controls_textfield"}
  textfield.focus()
  local delButton = my_table.add{type="button", name="del_button", caption={"test-mod.Del"}, style = "red_button"}
  delButton.style.font = "default-dialog-button"  
  delButton.style.width = 80
  delButton.style.height = 33
  local button = my_table.add{type="button", name="ugg_controls_toggle", caption={"test-mod.Add"}, style = "confirm_button"}
  button.style.width = 80
  local listbox = controls_flow.add{type = "list-box", name = "ugg_controls_listbox"}
  listbox.style.height = 300
  local listbox2 = controls_flow.add{type= "list-box", name="ugg_controls_listbox2", visible = false}
  listbox2.style.minimal_height = 100
  local exitBtn = controls_flow.add{type= "button", name="ugg_controls_toggle2", caption={"test-mod.tp_exit"}, style = "red_back_button"}
  exitBtn.style.width = 100
  exitBtn.style.horizontal_align = "left"
  exitBtn.style.left_margin = 350
  exitBtn.style.height = 33
    if global.players[event.player_index] ~= nil then 
      for i in pairs(global.players[event.player_index]) do
          listbox.add_item(i)
      end
    end
    
    for i, p in pairs(game.players) do
      if p.character and p.name ~= game.get_player(event.player_index).name then
        listbox2.visible = true
        listbox2.add_item(p.name)
      end
    end
  
end

script.on_event(defines.events.on_gui_click, function(event)
    local player = game.get_player(event.player_index)
    if event.element.name == "ugg_controls_toggle2" then
        local player_global = global.players[event.player_index]

        local control_toggle = event.element
        player.gui.screen.ugg_main_frame.destroy()
        
    elseif event.element.name == "ugg_controls_toggle" then
        local text = player.gui.screen.ugg_main_frame.content_frame.controls_flow.my_table.ugg_controls_textfield
        local list = player.gui.screen.ugg_main_frame.content_frame.controls_flow.ugg_controls_listbox
        if rawget(global.players, event.player_index) == nil then
          global.players[event.player_index] = {}
        end
        if rawget(global.players[event.player_index], text.text) == nil then
          list.add_item(text.text)
          global.players[event.player_index][text.text] = {x = player.position.x, y = player.position.y, surface = player.surface_index}
          local serialized_data = serpent.block(global.players)
          settings.global["coords-settings"] = {value = serialized_data}
        end
    elseif event.element.name == "del_button" then
      local list = player.gui.screen.ugg_main_frame.content_frame.controls_flow.ugg_controls_listbox
      local text = player.gui.screen.ugg_main_frame.content_frame.controls_flow.my_table.ugg_controls_textfield
      
      for key, val in ipairs(list.items) do
        if text.text == val then
          global.players[event.player_index][text.text] = nil
          list.remove_item(key)
          local serialized_data = serpent.block(global.players)
          settings.global["coords-settings"] = {value = serialized_data}
        end
      end
    --  if text.text == list.items[list.selected_index] then
    --    global.players[event.player_index][text.text] = nil
    --   list.remove_item(list.selected_index)
    --  end
    end
end)

script.on_event(defines.events.on_gui_selection_state_changed, function(event)
    local player = game.get_player(event.player_index)
    local text = player.gui.screen.ugg_main_frame.content_frame.controls_flow.my_table.ugg_controls_textfield
    --local serialized_data = serpent.block(global.players)
    --settings.global["coords-settings"] = {value = serialized_data}
    game.print(serialized_data)
    if event.element.name == "ugg_controls_listbox" then
      local list = event.element
      local tags = list.items[list.selected_index]
      text.text = tags
      local coords = global.players[event.player_index][tags]
      local x = coords.x;
      local y = coords.y;
      local surface = coords.surface;
      game.print(tags)
      game.get_player(event.player_index).teleport({x, y}, surface)
      
    elseif event.element.name == "ugg_controls_listbox2" then
      local list = event.element
      local nameOfPlayer = list.items[list.selected_index]
      
      for i, p in pairs(game.players) do
        if p.character and p.name == nameOfPlayer then
          tp(player, p.position, p.surface)
        end
      end
        
    end
end)


script.on_init(function()
  
end)

script.on_load(function()
  
end)


script.on_configuration_changed(function(data)
  
end)
