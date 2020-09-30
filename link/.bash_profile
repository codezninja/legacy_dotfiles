if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

complete -C aws_completer aws

export PATH=$PATH:~/go/bin
export PATH="$HOME/.jenv/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
[[ "$(type -P brew)" ]] && export PATH="/usr/local/sbin:$PATH"
[[ "$(type -P python3)" ]] && export PATH="$(python3 -m  site --user-base)/bin:$PATH"

eval "$(jenv init -)"

function terraform-compliance { docker run --rm -v $(pwd):/target -i -t eerkunt/terraform-compliance "$@"; }

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

