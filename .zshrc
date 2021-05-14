export VISUAL=vim
export EDITOR=$VISUAL

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1

# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ -n $current_branch ]]; then
    echo " (%{$fg_bold[yellow]%}$current_branch%{$reset_color%})"
  fi
}

setopt promptsubst

# Allow exported PS1 variable to override default prompt.
if ! env | grep -q '^PS1='; then
  PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}👽 %{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info) \$ '
fi

# brew
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# rvm
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

# Load and run compinit
autoload -U compinit && compinit -i

# don't highlight pasted text
unset zle_bracketed_paste
