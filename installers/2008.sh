# Skyland
mkdir -p "$game_data/Textures"
cp -al {1..8}0_*/* 32*/* 34*/* {91..94}*/* {96..98}*/* 100*/01*/0{1,5}*/* 1{1..2}0*/* 131*/* "$game_data"
cp -al 130*/Skyking*/textures/* "$game_data/Textures"
if is_enabled 2002; then
	cp -al 33*/* "$game_data"
fi
if is_enabled TODO_MAJESTIC_MOUNTAINS; then
	cp -al 01*/M*/*Tan/textures/* "$game_data/Textures"
else
	cp -al 01*/V*/Tan/Textures "$game_data"
fi
if is_enabled TODO_FALSKAAR; then
	cp -al 11*/*Falskaar/* "$game_data"
fi
