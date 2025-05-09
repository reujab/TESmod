# JK's Skyrim Fishing Patch
if [[ -f $game_data/ccBGSSSE001-Fish.esm ]]; then
	cp -al * "$game_data"
else
	echo "Fishing (CC) is not installed. Skipping patch."
fi
