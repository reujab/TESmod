# Navigator
cp -al Full/*.esl "$game_data"
if is_enabled TODO_3DNPC; then
	cp -al Modular/3DNPC* "$game_data"
fi
if is_enabled TODO_VIGILANT; then
	cp -al Modular/Vigilant* "$game_data"
fi
