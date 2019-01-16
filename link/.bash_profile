if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
complete -C aws_completer aws
export PATH=$PATH:~/go/bin
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export PATH="/usr/local/opt/openssl/bin:$PATH"
