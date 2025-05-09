# JK's Skyrim - Pets of Skyrim Patch
if [[ -f $game_data/ccVSVSSE002-Pets.esl ]]; then
	cp -al * "$game_data"
else
	echo "Pets of Skyrim is not installed. Skipping patch."
fi
