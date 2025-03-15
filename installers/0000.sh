# SKSE
cp -al *.{dll,exe} "$game_dir"
cp -al Scripts "$game_data"
if [[ ! -f $game_dir/SkyrimSELauncher.vanilla.exe ]]; then
	mv "$game_dir/SkyrimSELauncher"{,.vanilla}.exe
fi
# Force Steam to load SKSE
cp -al "$game_dir/skse64_loader.exe" "$game_dir/SkyrimSELauncher.exe"
