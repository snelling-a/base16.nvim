#!/usr/bin/env bash

#####################################################################
#*******************************************************************#
#* A simple script to:                                             *#
#* - fetch the latest Base16 Schemes from the central repository   *#
#*   - https://github.com/tinted-theming/base16-schemes            *#
#* - convert the `yaml` to `lua`                                   *#
#* - generate a list of all the builtin colorschemes               *#
#* - run `stylua` on the generated lua files                       *#
#*                                                                 *#
#* Requirements:                                                   *#
#* - stylua                                                        *#
#* - bash                                                          *#
#* - git                                                           *#
#* - fd                                                            *#
#*******************************************************************#
# ###################################################################

tools_dir="$(dirname "$0")"
schemes_source="https://github.com/tinted-theming/schemes.git"
schemes_dir="$tools_dir/base16-schemes"
colors_dir="$(dirname tools_dir)/colors"
readme="README.md"
start_text="<!--start autogenerated list-->"
end_text="<!--end autogenerated list-->"
schemes_list="schemes.temp"

prepare() {
  if [ ! -d "$colors_dir" ]; then
    echo "Creating colors directory..."
    mkdir -p "$colors_dir"
  fi

}

get_schemes() {
  if [ ! -d "$schemes_dir/base16-schemes/" ]; then
    echo "Cloning base16-schemes..."
    git clone -q --depth=1 "$schemes_source" "$schemes_dir" &
  else
    echo "Pulling latest changes..."
    git \
      --git-dir="$schemes_dir" \
      --work-tree="$schemes_dir" \
      pull -q &
  fi
  wait
  echo "Done"
}
purge_colors() {
  echo "Purging old colorschemes..."
  rm -rf "$colors_dir/*.lua"
  echo "Purging old colorscheme list..."
  sed -i "/^$start_text/,/$end_text/{/^$start_text/!{/^$end_text/!d;};}" "$readme"
}

generate_lua() {
  scheme="$1"
  echo 'require("base16").setup({'
  for color in base0{0..9} base0{A..F}; do
    value=$(sed -ne 's/'"$color"': "\(.*\)".*/\1/p' "$scheme" | tr -d '[:space:]')
    printf '\t%s = "%s",\n' "$color" "#$value"
  done
  printf '})\n\nvim.g.colors_name = "base16-%s"' "$(basename "$scheme" | cut -d. -f1)"
}

loop() {
  echo "Updating lua themes..."
  mkdir -p "$colors_dir"
  schemas="$(fd --glob '*.yaml' --no-ignore "$schemes_dir/base16" | sort)"
  for scheme in $schemas; do
    fbname=$(basename "$scheme" | cut -d. -f1)
    generate_lua "$scheme" >"$colors_dir/base16-$fbname.lua" &
    echo "- $fbname" >>"$schemes_list"
  done
  wait
  echo "Done!"
}

generate_docs() {
  sed -i "/$start_text/r $schemes_list" "$readme"
}

cleanup() {
  echo "Cleaning up..."
  rm -rf "$schemes_dir" "$schemes_list"
}

run() {
  prepare
  purge_colors
  get_schemes
  loop
  stylua .
  generate_docs
  cleanup
}

run
