# Immersive Creatures - Saints and Seducers CC Patch
if [[ -f $game_data/ccBGSSSE025-AdvDSGS.esm ]]; then
	cp * "$game_data"
else
	echo "Saints and Seducers CC not installed. Skipping patch."
fi
