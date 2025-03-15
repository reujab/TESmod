# Immersive College of Winterhold
cp -al 00*/* "$game_data"
if is_enabled 2075; then
	cp -al 17*/* "$game_data"
fi
if is_enabled 4002; then
	cp -al 05*/* "$game_data"
fi
# TODO: Ordinator
