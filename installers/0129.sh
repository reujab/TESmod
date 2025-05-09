# NARC Remade
if is_enabled TODO-FALSKAAR; then
	cp -al "NARC for Falskaar"/* "$game_data"
else
	cp -al NARC/* "$game_data"
fi
if is_enabled TODO-FORGOTTEN-CITY; then
	cp -al "Patch for Forgotten City"/* "$game_data"
fi
