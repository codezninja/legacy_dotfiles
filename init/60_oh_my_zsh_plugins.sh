# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Oh-My-ZSH plugins
plugins=(
  zsh-users/zsh-syntax-highlighting
)

# Oh-My-ZSH themes
themes=(
  bhilburn/powerlevel9k
)

# Install Oh-My-ZSH plugins.
function zsh_install_plugins() {
  PLUGINS_DIR=${ZSH_CUSTOM:-~/.dotfiles/vendor/oh-my-zsh/custom}/plugins
  plugins=($(setdiff "${plugins[*]}" "$(brew list)"))
  if (( ${#plugins[@]} > 0 )); then
    e_header "Installing Oh-My-ZSH plugins: ${plugins[*]}"
    for plugin in "${plugins[@]}"; do
      tar_dir=`basename $plugin`
      if [ ! -d ${PLUGINS_DIR}/${tar_dir} ]; then
        git clone https://github.com/$plugin.git ${PLUGINS_DIR}/${tar_dir}
      else
        e_arrow "$tar_dir plugin already exists."
      fi
    done
  fi
}

# Install Oh-My-ZSH themes.
function zsh_install_themes() {
  THEMES_DIR=${ZSH_CUSTOM:-~/.dotfiles/vendor/oh-my-zsh/custom}/themes
  themes=($(setdiff "${themes[*]}" "$(brew list)"))
  if (( ${#themes[@]} > 0 )); then
    e_header "Installing Oh-My-ZSH themes: ${themes[*]}"
    for theme in "${themes[@]}"; do
      tar_dir=`basename $theme`
      if [ ! -d ${THEMES_DIR}/${tar_dir} ]; then
        git clone https://github.com/$theme.git ${THEMES_DIR}/${tar_dir}
      else
        e_arrow "$tar_dir theme already exists."
      fi
    done
  fi
}

zsh_install_plugins
zsh_install_themes