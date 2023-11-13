# Show active branch name.
get_branch() {
    if command -v git &>/dev/null; then
        GIT_BRANCH=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

        if [ ! -z $GIT_BRANCH ]; then
            echo $GIT_BRANCH
        else
            echo "~"
        fi
    fi
}

# Toggle the prompt view.
toggle_prompt() {
    case $1 in
    "focus")
        export PS1='\[\033[00;34m\]---\[\033[00m\]\n\n'
        ;;
    "full")
        export PS1='\[\033[00;34m\]\nhost: \[\033[00;33m\]\h\[\033[00;34m\]  path: \[\033[00;33m\]\w\[\033[00;34m\]  branch: \[\033[00;33m\]$(get_branch)\[\033[00;34m\]  \n\n\[\033[00m\]'
        ;;
    *)
        toggle_prompt full
        ;;
    esac
}

# Add handy aliases.
alias tp='toggle_prompt'
alias toggle='toggle_prompt'

# Load the default prompt view.
toggle_prompt
