# Landscape and Water Fixes
mkdir -p "$game_data"{Meshes,Scripts}
cp -al _core/*.esp "$game_data"
cp -al _core/meshes/* "$game_data/Meshes"
cp -al _core/scripts/* "$game_data/Scripts"
if [[ -f $game_data/ccbgssse064-ba_elven.esl ]]; then
	cp -al Patches/_CC/*Elven\ Hunter/* "$game_data"
fi
if [[ -f $game_data/ccvsvsse004-beafarmer.esl ]]; then
	cp -al Patches/_CC/Farming/* "$game_data"
fi
if [[ -f $game_data/cceejsse004-hall.esl  ]]; then
	cp -al Patches/_CC/Hendraheim/* "$game_data"
fi
if [[ -f $game_data/cceejsse001-hstead.esm  ]]; then
	cp -al Patches/_CC/Tundra\ Homested/* "$game_data"
fi
if is_enabled 2002; then
	cp -al "Walkway Wall Fix/SMIM/meshes"/* "$game_data/Meshes"
else
	cp -al "Walkway Wall Fix/Vanilla/meshes/"* "$game_data/Meshes"
fi
if is_enabled TODO_ELFX; then
	cp -al Patches/ELFX\ Exteriors/meshes/* "$game_data/Meshes"
fi
if is_enabled TODO_MAJESTIC_MOUNTAINS; then
	cp -al Patches/Majestic\ Mountains/* "$game_data"
fi
