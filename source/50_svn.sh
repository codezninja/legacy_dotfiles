alias svnadd="svn add --force * --auto-props --parents --depth infinity -q"
alias svnrm="svn st | grep ^! | awk '{print \" --force \"$2}' | xargs svn rm"