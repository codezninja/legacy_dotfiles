# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

alias grep='grep --color=auto'

# Prevent less from clearing the screen while still showing colors.
export LESS=-XR

# Set the terminal's title bar.
function titlebar() {
  echo -n $'\e]0;'"$*"$'\a'
}

# SSH auto-completion based on entries in known_hosts.
if [[ -e ~/.ssh/known_hosts ]]; then
  complete -o default -W "$(cat ~/.ssh/known_hosts | sed 's/[, ].*//' | sort | uniq | grep -v '[0-9]')" ssh scp sftp
fi

#Terminal Notifier
alias tmn="terminal-notifier -message"

# Disable ansible cows }:]
export ANSIBLE_NOCOWS=1

#CMatrix Shortcut
alias cm='cmatrix -a -u 5 -s; clear'

dockertail() {
usage="dockertail (dev|pro) (tomcat | loggly | datadog) ip_address"
  if [ $# -ne 3 ]
    then
      echo $usage
  else
    ssh -i ~/.ssh/vic-deploy-$1.pem ec2-user@$3 "sudo docker logs --tail=100 -f \$(sudo docker ps | grep $2 | cut -f1 -d' ')"
  fi
}

alias mvndev='BUILD_VERSION=dev mvn clean package'
alias backup_consul='consul kv export vikings/ > ~/Backups/$(date +"%Y")/consul_backup_$(date +"%m%d%Y").json'
alias be='bundle exec'
alias tf='terraform'


urlencode() {
    # urlencode <string>
    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done

    LC_COLLATE=$old_lc_collate
}

urldecode() {
    # urldecode <string>

    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\\x}"
}

export_aws(){
  # usage: export_aws filename.csv
  # default will be set to credentials.csv if not specified
  file="${1:-credentials.csv}"
  echo "export creds from ${file}"
  export AWS_ACCESS_KEY_ID=$(tail -1 ${file} | cut -d, -f 1 | tr -d '\040\011\012\015')
  export AWS_SECRET_ACCESS_KEY=$(tail -1 ${file} | cut -d, -f 2 | tr -d '\040\011\012\015')
}

clear_aws() {
  # clear out all AWS_* environmnet variables
  unset $(env | grep -i ^aws | awk -F= '{print $1}')
}
