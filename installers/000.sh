# SKSE
cp -al skse64*/* "$game_dir"
if [[ ! -f $game_dir/SkyrimSELauncher.vanilla.exe ]]; then
	mv "$game_dir/SkyrimSELauncher"{,.vanilla}.exe
fi
# Force Steam to load SKSE
cp -al "$game_dir/skse64_loader.exe" "$game_dir/SkyrimSELauncher.exe"
