# Acoustic Space Improvement Fixes
cp -al 00*/* "$game_data"
if is_enabled 1014; then
	cp -al 01*/*ReverbInteriorSounds* "$game_data"
fi
