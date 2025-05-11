# Dragon Priests Retexture
cp -al 00*/{00,02,03,04,05,6,7,08}*/* "$game_data"
if is_enabled TODO_IMPROVED_HELMETS; then
	cp -al 00*/{12,13,15}*/* "$game_data"
fi
if is_enabled TODO_LOTD; then
	cp -al 00*/{36..38}*/* "$game_data"
fi
