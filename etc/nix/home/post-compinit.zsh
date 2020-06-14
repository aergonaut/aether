autoload -Uz promptinit
promptinit
autoload colors
colors

# Copy the most recent command to the clipboard
function _pbcopy_last_command(){
  history | tail -1 | sed 's/ *[0-9]* *//' | pbcopy
}
zle -N pbcopy-last-command _pbcopy_last_command
bindkey '^x^y' pbcopy-last-command

# Fuzzy match against history, edit selected value
_uniqe_without_sort() { awk '!x[$0]++' }
_fuzzy_history() {
  zle -U "$(
    history | \
    tail -2000 | \
    sed 's/ *[0-9]* *//' | \
    _uniqe_without_sort | \
    fzf --tac --reverse --no-sort
  )"
}
zle -N fuzzy-history _fuzzy_history
bindkey '^r' fuzzy-history

# Git branches
_fuzzy_git_branches() {
  zle -U "$(
    git branch --color=always | \
    grep -v '^* ' | \
    fzf --reverse --ansi --tac --select-1 | \
    sed -E 's/^[ \t]*//'
  )"
}
zle -N fuzzy-git-branches _fuzzy_git_branches
bindkey '^g^g' fuzzy-git-branches

# Git files
_fuzzy_git_status_files() {
  zle -U "$(
    git -c color.status=always status --short | \
    fzf --ansi --reverse --no-sort | \
    cut -d ' ' -f 3
  )"
}
zle -N fuzzy-git-status-files _fuzzy_git_status_files
bindkey '^g^f' fuzzy-git-status-files

# Git files
_fuzzy_git_shalector() {
  commit=$(
    git log --color=always --oneline --decorate --all -35 | \
    fzf --ansi --reverse --no-sort
  )
  zle -U "$(echo $commit | cut -d ' ' -f 1)"
  zle -M "$commit"
}
zle -N fuzzy-git-shalector _fuzzy_git_shalector
bindkey '^g^s' fuzzy-git-shalector
