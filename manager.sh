#!/bin/bash -eu
set -o pipefail

if [[ -n ${1+x} ]]; then
	echo "$1" > /tmp/mod.url
	exit 0
fi

if ! zenity --version &> /dev/null; then
	echo Zenity must be installed. 1>&2
	exit 1
fi

app_name=TESmod
config=$HOME/.config/$app_name
mod_list=mod-list.csv
enabled=$config/enabled.csv
mods=$config/mods
tmp=$config/tmp
nexus_game=skyrimspecialedition
rm -rf "$tmp"
mkdir -p "$config" "$mods" "$tmp"
touch "$enabled"
echo 0 > "$config/version"

cd "$(dirname "$0")"

cancel() {
	if zenity --title="Quit $app_name?" --text="Do you want to quit $app_name" --question; then
		exit 0
	else
		"$1"
	fi
}

contains() {
	local ele match="$1"
	shift
	for ele; do [[ $ele = "$match" ]] && return 0; done
	return 1
}

remove() {
	local ele match="$1"
	shift
	array=()
	for ele; do [[ $ele != "$match" ]] && array+=("$ele"); done
	return 0
}

set_game_dir() {
	if [[ -f ~/.local/share/Steam/steamapps/libraryfolders.vdf ]]; then
		while read -r library; do
			game_dir="$library/steamapps/common/Skyrim Special Edition"
			if [[ -f "$game_dir/SkyrimSE.exe" ]]; then
				return
			fi
		done < <(
			grep '"path"' ~/.local/share/Steam/steamapps/libraryfolders.vdf |
				awk '{print $2}' |
				sed 's/"//g'
		)
	fi
	if [[ -f $config/skyrim_dir.txt ]]; then
		game_dir=$(cat "$config/skyrim_dir.txt")
	else
		game_dir=$(zenity --title="Choose the Skyrim installation directory" --file-selection --directory) || true
	fi
	if [[ -z $game_dir ]]; then
		cancel set_game_dir
		return
	fi
	if [[ ! -f $game_dir/SkyrimSE.exe ]]; then
		zenity --title="Invalid installation directory" --text="Bad installation directory (missing SkyrimSE.exe): $game_dir" --error
		set_game_dir
		return
	fi
	echo "$game_dir" > "$config/skyrim_dir.txt"
}

set_nexus_key() {
	if [[ -f $config/nexus_key.txt ]]; then
		nexus_key=$(cat "$config/nexus_key.txt")
		return
	fi
	xdg-open https://next.nexusmods.com/settings/api-keys
	nexus_key=$(zenity --title="Nexus Mods API Key" --text="A browser window should have opened. Please scroll to the bottom of the page, request an API key, and paste it here." --entry) || true
	if [[ -z $nexus_key ]]; then
		cancel set_nexus_key
	fi
	echo "$nexus_key" > "$config/nexus_key.txt"
}

main_menu() {
	enabled_mod_count=$(wc -l < "$enabled")
	action=$(
		zenity --title="Choose action" --height=750 --list --radiolist --column= --column= --column= --hide-column=2 \
			FALSE patches "1) Configure patches" \
			FALSE audio "2) Configure audio mods" \
			FALSE texture_packs "3) Configure texture packs" \
			FALSE content "4) Configure content overhauls" \
			FALSE retextures "5) Configure retextures" \
			FALSE additions "6) Configure additions" \
			FALSE tweaks "7) Configure tweaks" \
			FALSE enb "8) Configure ENB/Weather" \
			TRUE install "Install $enabled_mod_count mods" \
			FALSE update "Update mods" \
			FALSE revert "Revert to vanilla" \
			FALSE play "Play (Steam)"
	) || true
	case $action in
		patches)
			configure '^02'
			;;
		audio)
			configure '^1'
			;;
		install)
			install
			;;
		update)
			update
			;;
		revert)
			revert
			;;
		play)
			steam steam://rungameid/489830
			;;
		*)
			exit 0
	esac
	main_menu
}

configure() {
	local cmd unselected_ids=() first_time=1 line id mod_name download link selected_ids unselected_ids dependants=() dependant_id
	cmd=(zenity --title="Select mods" --height=512 --width=896 --list --checklist --column= --column= --column= --column= --hide-column=2 --editable --separator=" ")
	# All mods in this category.
	# Remember which mods the user selected.
	if grep "$1" "$enabled" > /dev/null; then
		first_time=0
	fi
	# Read all mods in this category.
	while read -r line; do
		id=$(cut -d, -f1 <<< "$line")
		unselected_ids+=("$id")
		mod_name=$(cut -d, -f2 <<< "$line")
		download=$(cut -d, -f4 <<< "$line")
		if [[ $download != http* ]]; then
			link=https://www.nexusmods.com/$nexus_game/mods/$(cut -d: -f1 <<< "$download")
		fi
		if [[ $first_time = 1 ]] || grep "^$id" "$enabled" > /dev/null; then
			cmd+=(TRUE)
		else
			cmd+=(FALSE)
		fi
		cmd+=("$id" "$mod_name" "$link")
	done < <(grep "$1" "$mod_list")
	# Prompt the user for input.
	selected_ids=$("${cmd[@]}") || return 0

	# Create new enabled mod list.
	grep -vE "$1|^9" "$enabled" > "$enabled.new"
	# Enable and download selected mods and dependencies.
	for id in $selected_ids; do
		download "$id"
		remove "$id" "${unselected_ids[@]}"
		unselected_ids=("${array[@]}")
	done
	# Disable mods that depend on unselected mods.
	for id in "${unselected_ids[@]}"; do
		while read -r line; do
			dependant_id=$(cut -d, -f1 <<< "$line")
			if ! grep "^$dependant_id" "$enabled" > /dev/null; then
				continue
			fi
			mod_name=$(cut -d, -f2 <<< "$line")
			if ! contains "$mod_name" "${dependants[@]}"; then
				dependants+=("$mod_name")
			fi
			sed -i "/$dependant_id/ d" "$enabled.new"
		done < <(grep "\<$id\>" "$mod_list" | grep -v "^$id")
	done
	download_patches
	if [[ ${#dependants[@]} != 0 ]]; then
		if ! zenity --title="Disabled dependants" --text="Additionally disabled ${#dependants[@]} dependants:" --list --column=Mod "${dependants[@]}"; then
			configure "$@"
			return
		fi
	fi
	mv "$enabled.new" "$enabled"
}

download() {
	local dependencies dependency download nxm_link
	IFS=";" read -ra dependencies < <(grep "^$1" "$mod_list" | cut -d, -f5)
	for dependency in "${dependencies[@]}"; do
		download "$dependency"
	done

	if [[ -d $(get_mod_dir "$1") ]]; then
		enable_mod "$1"
		return
	else
		# Remove old versions
		find "$mods" -maxdepth 1 -name "$1*" -exec rm -rf {} +
	fi
	download=$(grep "^$1" $mod_list | cut -d, -f4)
	if [[ $download = http* ]]; then
		extract "$1" "$download"
	else
		nexus_id=$(cut -d: -f1 <<< "$download")
		file_id=$(cut -d: -f2 <<< "$download")
		rm -f /tmp/mod.url
		xdg-open "https://www.nexusmods.com/$nexus_game/mods/$nexus_id?tab=files&file_id=$file_id&nmm=1"
		echo Waiting for helper...
		while [[ ! -f /tmp/mod.url ]]; do
			sleep 0.1
		done
		nxm_link=$(cat /tmp/mod.url)
		rm -f /tmp/mod.url
		handle_nxm_link "$1" "$nxm_link"
	fi
	enable_mod "$1"
}

get_mod_dir() {
	local name version
	name=$(grep "^$1" "$mod_list" | cut -d, -f2)
	version=$(grep "^$1" "$mod_list" | cut -d, -f3)
	echo "$mods/$1 $name $version"
}

enable_mod() {
	if ! grep "^$1" "$enabled.new" > /dev/null; then
		echo "$1" >> "$enabled.new"
	fi
}

download_patches() {
	local line
	while read -r line; do
		IFS=";" read -ra dependencies < <(cut -d, -f5 <<< "$line")
		for dependency in "${dependencies[@]}"; do
			if ! grep "^$dependency" "$enabled.new" > /dev/null; then
				continue 2
			fi
		done
		id=$(cut -d, -f1 <<< "$line")
		download "$id"
	done < <(grep "^9" "$mod_list")
}

extract() {
	local mod_data
	curl "${2// /%20}" > "$tmp/$1"
	# Unfortunately, 7z cannot extract from stdin
	mod_data=$(get_mod_dir "$1")
	7z x "$tmp/$1" -o"$mod_data"
	rm "$tmp/$1"
	clean_mod_data "$mod_data"
}

handle_nxm_link() {
	local meta_url download
	meta_url=${2/nxm:\//https://api.nexusmods.com/v1/games}
	meta_url=${meta_url/\?/\/download_link.json?}
	download=$(curl -H "apiKey: $nexus_key" "$meta_url" | jq -r '.[0].URI')
	extract "$1" "$download"
}

clean_mod_data() {
	pushd "$1" > /dev/null
	rm -rf BashTags
	mv meshes Meshes 2> /dev/null || true
	mv textures Textures 2> /dev/null || true
	popd > /dev/null
}

install() {
	local id name mod_data installer mod_count
	if [[ -d $game_dir.vanilla ]]; then
		revert
	else
		cp -al "$game_dir"{,.vanilla}
	fi

	while read -r id; do
		name=$(grep "^$id" $mod_list | cut -d, -f2)
		echo "Installing $id $name"
		mod_data=$(get_mod_dir "$id")
		game_data="$game_dir/Data"
		if [[ -f installers/$id.sh ]]; then
			installer=$(cat "installers/$id.sh")
			pushd "$mod_data" > /dev/null
			eval "$installer"
			popd > /dev/null
		else
			cp -al "$mod_data"/* "$game_data"
		fi
	done < <(sort "$enabled")

	rm -rf "$game_data"/fomod

	mod_count=$(wc -l < "$enabled")
	zenity --title=Success --text="Installed $mod_count mods." --info
}

revert() {
	if [[ -d $game_dir.vanilla ]]; then
		rm -rf "$game_dir"
		cp -al "$game_dir"{.vanilla,}
	else
		zenity --text="No backup to restore from!" --error
	fi
}

update() {
	local update_count=0 id dir
	cp -al "$game_dir"{,".bak-$(date +%s)"}
	while read -r id; do
		dir=$(get_mod_dir "$id")
		if [[ ! -d $dir ]]; then
			download "$id"
			((update_count+=1))
		fi
	done < "$enabled"
	zenity --text="Updated $update_count mods." --info
}

set_game_dir
set_nexus_key
main_menu
