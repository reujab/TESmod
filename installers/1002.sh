# Audio Overhaul
cp -al "00 Core Files"/* "$game_data"
# TODO: Install Enhanced Blood Textures patch
if is_enabled TODO-EBT; then
	cp -al "00 Patch Plugins/AOS_EBT Patch.esp" "$game_data"
fi
