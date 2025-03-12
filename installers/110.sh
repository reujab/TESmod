# Acoustic Space Improvement Fixes
cp -al 00*/* "$game_data"
if grep '^112' "$enabled" > /dev/null; then
	cp -al 01*/*ReverbInteriorSounds* "$game_data"
fi
