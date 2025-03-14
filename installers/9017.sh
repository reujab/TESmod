# JK's Raven Rock Patch Collection
if [[ -f $game_data/ccBGSSSE001-Fish.esm ]]; then
	cp -al *Fishing* "$game_data"
fi
if is_enabled 0100; then
	cp -al *USSEP* "$game_data"
fi
if is_enabled 3002; then
	cp -al *LotD* "$game_data"
fi
# TODO: AI Overhaul
