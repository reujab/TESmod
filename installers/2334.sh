# RS Children Overhaul
mkdir -p "$game_data/Meshes"
cp -al 00*/* "$game_data"
cp -al 03*/*Animations/meshes/* "$game_data/Meshes"
if is_enabled 0147; then
	cp -al 01*/Non*USSEP/* "$game_data"
else
	cp -al 01*/Non\ Playable/* "$game_data"
fi
