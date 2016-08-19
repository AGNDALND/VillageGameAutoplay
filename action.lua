function on_msg_receive (msg)
      if msg.from.print_name==msg.to.print_name then
          if(msg.text=="pause" or msg.text=="Pause")then
		file=io.open("VillageGameAutoplay/setting.json","w")
		io.output(file)
		io.write('{"quest": 1, "fight": 1, "pause": 1}')
		io.close(file)
	 	send_msg(msg.from.print_name,"Auto quest/fight paused.",status_offline,false)
	elseif(msg.text=="resume" or msg.text=="Resume")then
		file=io.open("VillageGameAutoplay/setting.json","w")
		io.output(file)
		io.write('{"quest": 1, "fight": 1, "pause": 0}')
		io.close(file)
	 	send_msg(msg.from.print_name,"Auto quest/fight resumed.",status_offline,false)
	elseif(msg.text=="/11")then
		file=io.open("VillageGameAutoplay/setting.json","w")
		io.output(file)
		io.write('{"quest": 1, "fight": 1, "pause": 0}')
		io.close(file)
	 	send_msg(msg.from.print_name,"Quest = true    Fight = true",status_offline,false)
	elseif(msg.text=="/10")then
		file=io.open("VillageGameAutoplay/setting.json","w")
		io.output(file)
		io.write('{"quest": 1, "fight": 0, "pause": 0}')
		io.close(file)
	 	send_msg(msg.from.print_name,"Quest = true    Fight = false",status_offline,false)
	elseif(msg.text=="/01")then
		file=io.open("VillageGameAutoplay/setting.json","w")
		io.output(file)
		io.write('{"quest": 0, "fight": 1, "pause": 0}')
		io.close(file)
	 	send_msg(msg.from.print_name,"Quest = false    Fight = true",status_offline,false)
	elseif(msg.text=="/00")then
		file=io.open("VillageGameAutoplay/setting.json","w")
		io.output(file)
		io.write('{"quest": 0, "fight": 0, "pause": 0}')
		io.close(file)
	 	send_msg(msg.from.print_name,"Quest = false    Fight = false",status_offline,false)
	elseif(msg.text=="/settings" or msg.text=="/Settings")then
		file=io.open("VillageGameAutoplay/setting.json","w")
		settings=read(file)
		io.close(file)
	 	send_msg(msg.from.print_name,settings,status_offline,false)
	elseif(msg.text=="/setlang_it" or msg.text=="/italiano")then
		setlang('it')
	 	send_msg(msg.from.print_name,'Lingua impostata in italiano!',status_offline,false)
	elseif(msg.text=="/setlang_de" or msg.text=="/deutsch")then
		setlang('de')
	 	send_msg(msg.from.print_name,'Sprache auf Deutsch eingestellt!',status_offline,false)
	elseif(msg.text=="/setlang_en" or msg.text=="/english")then
		setlang('en')
	 	send_msg(msg.from.print_name,'Language set to English!',status_offline,false)

	end
      end

      if (msg.from.print_name == "Village_Game" )then
	if (msg.text==nil) then
		msg.text="Bandits attacked a village. The mayor asked for help - Banditen haben ein Dorf angegriffen. - I banditi hanno attaccato il villaggio"
	end
	msg.text=string.gsub(msg.text, "'", "#")
	tmp=string.format("%s",msg.text)
	tmp2=io.popen('python3 VillageGameAutoplay/village_game.py "'..tmp..'"'):read()
      	r=string.format("%s",tmp2)

	if ( r ~= "nil" ) then
	 	send_msg(msg.from.print_name,r,status_offline,false)
		mark_read(msg.from.print_name)
	end
      end

  end


function on_our_id(id)
end

function on_secret_chat_created(peer)
end

function on_secret_chat_update(peer)
end

function on_user_update(user)
end

function on_chat_update(user)
end

function on_get_difference_end()
end

function on_binlog_replay_end()
end

function setlang(lang)
	file_origin=io.open("VillageGameAutoplay/village_game_"..lang..".py","r")
		print("VillageGameAutoplay/village_game_"..lang..".py")
		io.input(file_origin)
		t=io.read('*a')
	io.close(file_origin)
	file_dest=io.open("VillageGameAutoplay/village_game.py","w")
		io.output(file_dest)
		io.write(t)
	io.close(file_dest)
end
