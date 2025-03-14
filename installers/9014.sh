# JK's Guild HQ Interiors Patch Collection
if is_enabled 0100; then
	cp -al *USSEP* "$game_data"
fi
if is_enabled 1006; then
	cp -al *Sounds\ of\ Skyrim* "$game_data"
	rm "$game_data/JKs Jorrvaskr - Sounds of Skyrim - "{ELE,Lux}" patch.esp"
fi
if is_enabled 3002; then
	cp -al *LOTD* "$game_data"
	rm "$game_data/JKs Bards College - Aran di Kono LOTD Patch.esp"
fi
rm -rf "$game_data"/JKs\ College*
# TODO: 3DNPC, AI Overhaul, Embers XD
