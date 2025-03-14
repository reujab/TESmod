# Legacy of the Dragonborn Patches
if is_enabled 1004; then
	cp -al 06\ ISC/* "$game_data"
fi
if is_enabled 2002; then
	cp -al 06zzSMIM/* "$game_data"
fi
if is_enabled 3004; then
	cp -al 04\ FCP/* "$game_data"
fi
if is_enabled 3006; then
	cp -al 04\ FKP/* "$game_data"
fi
if is_enabled 3008; then
	cp -al 01\ JKS/* "$game_data"
fi
if is_enabled 3100; then
	cp -al 04\ ICOW/* "$game_data"
fi
if is_enabled 3012; then
	cp -al 06\ JKAR/* "$game_data"
fi
if is_enabled 3016; then
	cp -al 06\ JKBEL/* "$game_data"
fi
if is_enabled 3020; then
	cp -al 06\ JKBP/* "$game_data"
fi
if is_enabled 3027; then
	cp -al 06\ JKDRA/* "$game_data"
fi
if is_enabled 3066; then
	cp -al 06\ JKBAN/* "$game_data"
fi
if is_enabled 3072; then
	cp -al 06\ JKDRU/* "$game_data"
fi
if is_enabled 3086; then
	cp -al 06\ JKWAR/* "$game_data"
fi
if is_enabled 4016; then
	cp -al 06zzRCI/* "$game_data"
fi
# TODO: Zim's Immersive Artifacts, Morrowloot Ultimate, Requiem, JSDaggers, JSRings, SRCEO, SkyTEST
