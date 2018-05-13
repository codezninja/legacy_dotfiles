declare -a arr=("~/.alks"
                "~/.vault_aliases"
                "~/.work_stuff"
                )

for f in "${arr[@]}"
do
  if [ -f $f ]; then
    source "$f"
  fi
done
