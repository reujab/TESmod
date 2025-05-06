# Audio Overhaul
cp -al "00 Core Files"/* "$game_data"
if is_enabled 4024; then
	cp -al "00 Patch Plugins/AOS_EBT Patch.esp" "$game_data"
fi
