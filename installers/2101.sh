# Animated Filled Soul Gems
cp -al */01*/* "$game_data"
if is_enabled TODO_ENB; then
	cp -al */02*/01*/* "$game_data"
else
	cp -al */03*/* "$game_data"
fi
if is_enabled TODO_YASTM; then
	cp -al */04*/YASTM* "$game_data"
fi
