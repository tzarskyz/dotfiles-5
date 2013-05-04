export PATH="~/bin:/usr/local/bin:/usr/local/share/npm/bin:$PATH:.:~"


# Support extended pattern matching in bash (e.g., for quantifiers like "*_+([0-9])")
shopt -s extglob
# Correct for minor spelling errors
shopt -s cdspell;
# When doing history expansion, pressing return simply loads the expanded command into the prompt,
# rather the immediately executing it (allowing for review or editing)
shopt -s histverify
# If history expansion fails, reload the original command into the prompt so it can be edited
shopt -s histreedit

# If directory given as a command, cd to that directory
# (Only supported in bash 4 and above)
if [ $BASH_VERSINFO -ge 4 ]
then
  shopt -s autocd
fi


export CLICOLOR=1
#export LSCOLORS=ExFxCxDxBxegedabagacad
# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

# Prompt will be 'username (pwd)$ ', colored with white-on-green
export PS1="\[\e[1;42m\]\u (\W)\$\[\e[0m\] "

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;\w\a\]$PS1"
    ;;
  *)
    ;;
esac


export HISTCONTROL=ignoredups:ignorespace;
# Change the file history commands are saved to
export HISTFILE=~/.shell_history
# Append to the existing history file, rather than overwriting it
shopt -s histappend;
# Save each command when the prompt is re-displayed, rather than only at shell exit
PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND/%;*( )/} ;} history -a";


export EDITOR='mvim -f'
export VISUAL='mvim -f'

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

if [ -f ~/.shell_aliases ]; then
  . ~/.shell_aliases
fi

if [ -f ~/.shell_commands ]; then
  source ~/.shell_commands
fi

# Tell MrSync (our rsync convienance wrapper) to use ~/.rsync_exclude.conf for exlcude patterns
export MRSYNC_EXCLUDE_FILE="~/.rsync_exclude.conf"

# Put junit in Java classpath
if [ -f ~/Dropbox/code/junit/junit-4.10.jar ]; then
    export CLASSPATH=~/Dropbox/code/junit/junit-4.10.jar:./:$CLASSPATH
fi

export PYTHONPATH="$(brew --prefix)/lib/python2.7/site-packages:$PYTHONPATH"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Display a message at login with an interactive shell if any homebrew packages need updating
# This assumes that `brew update` is regularly run (e.g., by cron) to pull the latest package info.
case "$-" in
*i*)    if [[ `brew outdated` != '' ]]; then
            echo -e "\e[1m\e[48;5;26m\e[38;5;125mhomebrew installed packages are outdated. Run \`brew outdated\` to see outdated packages, and \`brew upgrade\` to upgrade outdated packages.\e[0m"
            echo
        fi
        ;;
*)      continue ;;
esac

# Boomark and recalls functionaility
if [ -f ~/.dir_bookmark.sh ]; then
    . ~/.dir_bookmark.sh
fi

# Initialize 'autojump' utility
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# Initialize the 'Generic Colouriser' utility
[[ -s `brew --prefix`/etc/grc.bashrc ]] && . `brew --prefix`/etc/grc.bashrc
