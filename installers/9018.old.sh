# JK's Solutide Outskirts Patch Collection
# TODO: 3DNPC, AI Overhaul
if [[ -f $game_data/ccBGSSSE001-Fish.esm ]]; then
	cp -al *Fishing* "$game_data"
fi
if is_enabled 0100; then
	cp -al *USSEP* "$game_data"
fi
if is_enabled 1006; then
	cp -al *Sounds\ of\ Skyrim* "$game_data"
fi
if is_enabled 2002; then
	cp -al *SMIM* Meshes "$game_data"
fi
if is_enabled 3002; then
	cp -al *LOTD* "$game_data"
fi
cp -al "JKs Solitude Outskirts - JKs Skyrim patch.esp" "$game_data"
