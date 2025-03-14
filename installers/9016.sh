# JK's Markarth Outskirts Patch Collection
if [[ -f $game_data/ccBGSSSE001-Fish.esm ]]; then
	cp -al JKs\ Markarth*Fishing* "$game_data"
fi
if is_enabled 3002; then
	cp -al JKs\ Markarth*LotD* "$game_data"
fi
