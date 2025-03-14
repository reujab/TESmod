# JK's Interior Patch Collection
if [[ -f $game_data/ccBGSSSE001-Fish.esm ]]; then
	cp -al "JKs Winking Skeever - Fishing Patch.esp" "JKs Sinderions Field Laboratory - CC - Fishing patch.esp" "$game_data"
fi
if is_enabled 0100; then
	cp -al *-\ USSEP* "$game_data"
fi
if is_enabled 1006; then
	cp -al *Sounds\ of\ Skyrim* "$game_data"
fi
if is_enabled 3002; then
	cp -al *LOTD* "$game_data"
	rm "$game_data/JKs Blue Palace - JKs Skyrim - LOTD - Solitude Skyway Patch.esp"
	rm "$game_data/JKs Blue Palace - Solitude Skyway - LOTD Patch.esp"
	rm "$game_data/JKs Blue Palace - Enhanced Solitude - LOTD Patch.esp"
	rm "$game_data/JKs Blue Palace - Enhanced Solitude - Solitude Skyway - LOTD Patch.esp"
	# Crashing (2025-03)
	rm "$game_data/JKs Blue Palace - JKs Skyrim - LOTD Patch.esp"
fi
rm -rf "$game_data"/JKs\ College*

# TODO: AI Overhaul, Rugnarok, 3DNPC, Embers XD
