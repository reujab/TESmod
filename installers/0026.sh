# Faster HDT-SMP
mkdir -p "$game_data/SKSE/Plugins/hdtSkinnedMeshConfigs"
cp -al V1_6_1170_NOCUDA_AVX/* "$game_data"
cp -al configs/*performance.xml "$game_data/SKSE/Plugins/hdtSkinnedMeshConfigs/configs.xml"
