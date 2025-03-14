# JK's Whiterun Exteriors Patch Collection
if [[ -f $game_data/ccBGSSSE001-Fish.esm ]]; then
	cp -al JKs\ Whiterun\ Outskirts*Fishing* "$game_data"
fi
if is_enabled 0100; then
	cp -al JKs\ Whiterun\ Outskirts*USSEP* "$game_data"
fi
# TODO: 3DNPC, SkyTEST
