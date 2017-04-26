# Editing

# if [[ ! "$SSH_TTY" ]] && is_osx; then
#   export EDITOR='mvim'
#   export LESSEDIT='mvim ?lm+%lm -- %f'
# else
  export EDITOR='vim'
# fi

function openInSublime() {
  if [ -f *.sublime-project ]; then
    subl --project *.sublime-project;
  else
    sublime_project_file_template="$(cat <<EOF
{
  "folders":
  [
    {
      "path": "."
    }
  ]
}
EOF
)"
    sublime_project_file_name="${PWD##*/}.sublime-project"
    echo "No Sublime Project Found ... Creating $sublime_project_file_name";
    echo "$sublime_project_file_template" >> $sublime_project_file_name

    subl --project *.sublime-project;
  fi
}

export VISUAL="$EDITOR"
alias q="$EDITOR"
alias qv="q $DOTFILES/link/.{,g}vimrc +'cd $DOTFILES'"
alias qs="q $DOTFILES"
alias sublp=openInSublime