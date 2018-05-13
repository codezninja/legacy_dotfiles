# IP addresses
alias wanip="dig +short myip.opendns.com @resolver1.opendns.com"
alias whois="whois -h whois-servers.net"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# View HTTP traffic
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# http_code check of url
function url_check() {
  GREEN=$(tput setaf 2)
  YELLOW=$(tput setaf 3)
  MAGENTA=$(tput setaf 5)
  NORMAL=$(tput sgr0)

  msg="${MAGENTA}${@}${NORMAL}"
  status=`curl -m 6 -o /dev/null --silent --head --write-out '%{http_code}\n' "$@"`
  if [[ $status == '200' ]]; then
    msg+=" | ${GREEN}$status${NORMAL}"
  else
    msg+=" | ${YELLOW}$status${NORMAL}"
  fi

  echo $msg
}
