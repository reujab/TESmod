# Immersive Creatures - Nixhound CC Patch
if [[ -f $game_data/ccBGSSSE035-PetNHound.esl ]]; then
	cp * "$game_data"
else
	echo "Nixhound CC not installed. Skipping patch."
fi
