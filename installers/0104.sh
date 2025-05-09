# Assorted Animation Fixes
cp -al 01*/* "$game_data"
if is_enabled 0017; then
	cp -al 03*/* "$game_data"
fi
