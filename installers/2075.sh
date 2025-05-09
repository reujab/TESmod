# JS Dragon Claws
cp -al Meshes Scripts Textures "$game_data"
if is_enabled TODO_LOTD; then
	cp -al patches/LOTDv6/*.esp "$game_data"
	cp -al patches/LOTDv6/meshesh/* "$game_data/Meshes"
fi
