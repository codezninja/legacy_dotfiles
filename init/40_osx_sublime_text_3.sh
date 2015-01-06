# OSX-only stuff. Abort if not OSX.
is_osx || return 1

sudo mkdir -p /etc/resolver

sudo tee /etc/resolver/dev >/dev/null <<EOF
nameserver 127.0.0.1
EOF