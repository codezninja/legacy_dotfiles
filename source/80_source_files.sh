declare -a arr=("${HOME}/.alks"
                "${HOME}/.vault_aliases"
                "${HOME}/.work_stuff"
                )

for f in "${arr[@]}"
do
  if [ -e "$f" ]; then
    source "$f"
  fi
done
