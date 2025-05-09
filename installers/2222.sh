# Terre's Fur Textures
mkdir -p "$game_data/Textures/actors/character"
if is_enabled 2200; then
	cp -al FEMALE/UNP/00*/textures/Actors/Character/* "$game_data/Textures/actors/character"
else
	cp -al FEMALE/Vanilla/00*/textures/Actors/Character/* "$game_data/Textures/actors/character"
fi
cp -al MALE/Vanilla/00*/textures/Actors/Character/* "$game_data/Textures/actors/character"
