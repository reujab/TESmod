# Acoustic Space Improvement Fixes
cp -al 00*/* "$game_data"
if [[ -f $game_data/ccvsvsse004-beafarmer.esl ]]; then
	cp -al 01*/*Farming* "$game_data"
fi
if [[ -f $game_data/ccbgssse025-advdsgs.esm ]]; then
	cp -al 01*/*Seducers.esp "$game_data"
fi
if is_enabled 1012; then
	cp -al 01*/*ReverbInteriorSounds* "$game_data"
fi
if is_enabled TODO_SHADOWS; then
	cp -al 01*/*Shadows* "$game_data"
fi
