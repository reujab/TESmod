# Embers XD
# TODO: RLO
mkdir -p "$game_data"/{Meshes,Textures}
cp -al plugins/esm/* "$game_data"
cp -al assets/core/meshes/{common,new}/meshes/* "$game_data/Meshes"
cp -al assets/core/textures/{common,embers}/textures/* "$game_data/Textures"
cp -al assets/magick/meshes/new/meshes/* "$game_data/Meshes"
cp -al assets/magick/textures/{common,new}/textures/* "$game_data/Textures"
cp -al "plugins/magick/Embers XD - Fire Magick Add-On.esp" "$game_data"
if ! grep iMaxDesired=10000 "$game_docs/SkyrimPrefs.ini" > /dev/null; then
	sed -i 's/iMaxDesired=.*/iMaxDesired=10000/' "$game_docs/SkyrimPrefs.ini"
	zenity --title="Embers XD" --text="Set [Particles] iMaxDesired=10000 in SkyrimPrefs.ini" --info
fi
if [[ -f $game_data/ccQDRSSE001-SurvivalMode.bsa ]]; then
	cp -al patches/Survival_Mode/* "$game_data"
fi
if is_enabled 3002; then
	cp -al patches/Legacy_of_the_Dragonborn/* "$game_data"
fi
if is_enabled 3008; then
	cp -al patches/JKs_Skyrim/* "$game_data"
fi
if is_enabled 3027; then
	cp -al patches/JKs_Dragonsreach/* "$game_data"
fi
