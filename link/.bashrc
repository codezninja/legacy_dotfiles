# Where the magic happens.
export DOTFILES=~/.dotfiles

# Add binaries into the path
PATH=$DOTFILES/bin:$PATH
export PATH

# Source all files in "source"
function src() {
  local file
  if [[ "$1" ]]; then
    source "$DOTFILES/source/$1.sh"
  else
    for file in $DOTFILES/source/*; do
      source "$file"
    done
  fi
}

# Run dotfiles script, then source.
function dotfiles() {
  $DOTFILES/bin/dotfiles "$@" && src
}

src

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/ezbon.jacob/Repos/ghe.coxautoinc.com/MAN-VIKings/image-order-processor/node_modules/tabtab/.completions/serverless.bash ] && . /Users/ezbon.jacob/Repos/ghe.coxautoinc.com/MAN-VIKings/image-order-processor/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/ezbon.jacob/Repos/ghe.coxautoinc.com/MAN-VIKings/image-order-processor/node_modules/tabtab/.completions/sls.bash ] && . /Users/ezbon.jacob/Repos/ghe.coxautoinc.com/MAN-VIKings/image-order-processor/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /private/tmp/tmp/audit-data-logger/api/node_modules/tabtab/.completions/slss.bash ] && . /private/tmp/tmp/audit-data-logger/api/node_modules/tabtab/.completions/slss.bash


alias skip_precommit="SKIP=flake8"
eval "$(/Users/ezbon.jacob/.pyenv/shims/alks-creds --bash-wrapper)"

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.bash ] && . ~/.config/tabtab/__tabtab.bash || true

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
