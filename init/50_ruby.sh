# Initialize rbenv.
source $DOTFILES/source/50_ruby.sh

# Install Ruby.
if [[ "$(type -P rbenv)" ]]; then
  versions=(2.3.1 2.5.1 jruby-9.1.1.0 jruby-9.2.5.0)

  rubies=($(setdiff "${versions[*]}" "$(rbenv whence ruby)"))
  if (( ${#rubies[@]} > 0 )); then
    e_header "Installing Ruby versions: ${rubies[*]}"
    for r in "${rubies[@]}"; do
      rbenv install "$r"
      rbenv exec gem install bundler
      [[ "$r" == "${versions[0]}" ]] && rbenv global "$r"
    done
  fi
fi
