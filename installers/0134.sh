# NPC AI Process Position Fix
cp -al SKSE "$game_data"
if is_enabled TODO_AIO; then
	cp -al patches/AI\ Overhaul/* "$game_data"
fi
