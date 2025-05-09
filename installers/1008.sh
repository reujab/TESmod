# Audio Overhaul
cp -al "00 Core Files"/* "$game_data"
if is_enabled TODO_EBT; then
	cp -al "00 Patch Plugins/AOS_EBT Patch.esp" "$game_data"
fi
