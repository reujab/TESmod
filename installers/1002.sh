# Audio Overhaul
cp -al "00 Core Files"/* "$game_data"
# TODO: Install Enhanced Blood Textures patch
if grep TODO "$enabled" > /dev/null; then
	cp -al "00 Patch Plugins/AOS_EBT Patch.esp" "$game_data"
fi
