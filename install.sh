#!/usr/bin/env bash
# Monokai - Gnome Terminal color scheme install script

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Monokai"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="Monokai"
[[ -z "$GCONFTOOL" ]] && GCONFTOOL=gconftool
[[ -z "$BASE_KEY" ]] && BASE_KEY=/apps/gnome-terminal/profiles

PROFILE_KEY="$BASE_KEY/$PROFILE_SLUG"

gset() {
  local type="$1"; shift
  local key="$1"; shift
  local val="$1"; shift

  "$GCONFTOOL" --set --type "$type" "$PROFILE_KEY/$key" -- "$val"
}

# Because gconftool doesn't have "append"
glist_append() {
  local type="$1"; shift
  local key="$1"; shift
  local val="$1"; shift

  local entries="$(
    {
      "$GCONFTOOL" --get "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
      echo "$val"
    } | head -c-1 | tr "\n" ,
  )"

  "$GCONFTOOL" --set --type list --list-type $type "$key" "[$entries]"
}

# Append the Monokai-Kepbod profile to the profile list
glist_append string /apps/gnome-terminal/global/profile_list "$PROFILE_SLUG"

gset string visible_name "$PROFILE_NAME"

gset string palette	"#1C1C1D1D1919:#D0D01B1A2424:#A7A7D3D32C2C:#D8D8CFCF6767:#6161B8B8D0D0:#69695A5ABBBB:#D5D538386464:#FEFEFFFFFEFE:#1C1C1D1D1919:#D1D12A292423:#A7A7D3D32C2C:#D8D8CFCF6767:#6161B8B8D0D0:#69695A5ABBBB:#D5D538386464:#FEFEFFFFFEFE"
gset string background_color "#232325252626"
gset string foreground_color "#F6F6F5F5EEEE"
gset string bold_color "#FF99FF88FF55"
gset bool   bold_color_same_as_fg "true"
gset bool   use_theme_colors "false"
gset bool   use_theme_background "false"
