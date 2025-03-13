# JK's Interior Patch Collection
if grep '^0100' "$enabled" > /dev/null; then
	cp -al *USSEP* "$game_data"
fi
if grep '^3002' "$enabled" > /dev/null; then
	cp -al *LOTD* "$game_data"
fi
# TODO: AI Overhaul, Rugnarok, Sounds of Skyrim, 3DNPC, Embers XD
