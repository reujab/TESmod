# Realistic Water Two
cp -al 000*/* "$game_data"
if is_enabled 3006; then
	cp -al *Falskaar*/* "$game_data"
fi
