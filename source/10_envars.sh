if [[ -e ~/.env ]]; then
  while read envar; do
    export "$envar"
  done < ~/.env
fi