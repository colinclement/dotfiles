#
# ~/.zshrc — prezto (migrated from oh-my-zsh)
#
# Prezto modules and their settings live in ~/.zpreztorc.
# The sections below recreate the oh-my-zsh behavior you were used to.
#

# --- Homebrew on PATH before prezto loads (its homebrew module needs it) ---
if (( ! $+commands[brew] )); then
  for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
    if [[ -x $_brew ]]; then
      eval "$($_brew shellenv)"
      break
    fi
  done
  unset _brew
fi

# --- Load prezto ---
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# =============================================================================
# Prompt: recreation of oh-my-zsh's "robbyrussell" theme
#   ➜  dirname git:(branch) ✗
# (prezto's own theme is set to 'off' in .zpreztorc)
# =============================================================================
setopt prompt_subst

_rr_git_prompt() {
  local ref
  ref=$(command git symbolic-ref --short HEAD 2>/dev/null) \
    || ref=$(command git rev-parse --short HEAD 2>/dev/null) \
    || return 0
  local out=" %B%F{blue}git:(%F{red}${ref//\%/%%}%F{blue})"
  if [[ -n $(command git status --porcelain --ignore-submodules=dirty 2>/dev/null | head -n 1) ]]; then
    out+=" %F{yellow}✗"
  fi
  print -rn -- "${out}%f%b"
}

PROMPT='%B%(?.%F{green}.%F{red})➜%f  %F{cyan}%c%f%b$(_rr_git_prompt) '
RPROMPT=''

# =============================================================================
# git — oh-my-zsh git plugin aliases
# (prezto's own git aliases are disabled in .zpreztorc so these don't clash)
# =============================================================================
git_current_branch() {
  command git symbolic-ref --short HEAD 2>/dev/null \
    || command git rev-parse --short HEAD 2>/dev/null
}

git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,master}; do
    if command git show-ref -q --verify "$ref"; then
      echo "${ref:t}"
      return 0
    fi
  done
  echo master
}

alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'
alias gc='git commit --verbose'
alias 'gc!'='git commit --verbose --amend'
alias gca='git commit --verbose --all'
alias gcam='git commit --all --message'
alias gcb='git checkout -b'
alias gcl='git clone --recurse-submodules'
alias gcm='git checkout $(git_main_branch)'
alias gcmsg='git commit --message'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch'
alias gfa='git fetch --all --tags --prune'
alias gl='git pull'
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias gm='git merge'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias 'gpf!'='git push --force'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gr='git remote'
alias grv='git remote --verbose'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grbm='git rebase $(git_main_branch)'
alias grh='git reset'
alias grhh='git reset --hard'
alias grs='git restore'
alias grst='git restore --staged'
alias gst='git status'
alias gss='git status --short'
alias gsta='git stash push'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gsw='git switch'
alias gswc='git switch --create'
alias gswm='git switch $(git_main_branch)'

# =============================================================================
# brew — oh-my-zsh brew plugin aliases
# =============================================================================
if (( $+commands[brew] )); then
  alias bi='brew install'
  alias bl='brew list'
  alias bo='brew outdated'
  alias bs='brew search'
  alias bu='brew update'
  alias bup='brew upgrade'
  alias bubo='brew update && brew outdated'
  alias bubu='bubo && bup'
  alias bcn='brew cleanup'
  alias bsl='brew services list'
fi

# =============================================================================
# common-aliases + oh-my-zsh directory shortcuts
# (rm/cp/mv -i and command correction come from prezto's utility module)
# =============================================================================
alias l='ls -lFh'
alias la='ls -lAFh'
alias ll='ls -l'
alias lr='ls -tRFh'
alias lt='ls -ltFh'
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'
alias lsr='ls -lARFh'
alias lsn='ls -1'

alias zshrc='${=EDITOR} ~/.zshrc'
alias t='tail -f'
alias dud='du -d 1 -h'
(( $+commands[duf] )) || alias duf='du -sh *'
alias hgrep='fc -El 0 | grep'
alias p='ps -f'
alias sortnr='sort -n -r'
alias unexport='unset'

alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L='| less'
alias -g LL='2>&1 | less'
alias -g CA='2>&1 | cat -A'
alias -g NE='2> /dev/null'
alias -g NUL='> /dev/null 2>&1'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -- -='cd -'
alias md='mkdir -p'
alias rd='rmdir'

# =============================================================================
# history — oh-my-zsh history plugin
# (oh-my-zsh's `history` listed everything; zsh's built-in shows only the last 16)
# =============================================================================
alias history='fc -l 1'
alias h='history'
alias hl='history | less'
alias hs='history | grep'
alias hsi='history | grep -i'

# =============================================================================
# python — oh-my-zsh python plugin
# =============================================================================
alias py='python3'
alias pyfind='find . -name "*.py"'
alias pygrep='grep -nr --include="*.py"'
alias pyserver='python3 -m http.server'

pyclean() {
  find "${@:-.}" -type f -name '*.py[co]' -delete
  find "${@:-.}" -depth -type d \( -name __pycache__ -o -name .mypy_cache -o -name .pytest_cache \) -exec rm -rf {} +
}

# mkv [name]: create a venv (default ./venv) and activate it
mkv() {
  local name="${1:-venv}"
  python3 -m venv "$name" && source "$name/bin/activate"
}

# vrun [name]: activate an existing venv (default ./venv)
vrun() {
  local name="${1:-venv}"
  if [[ -f "$name/bin/activate" ]]; then
    source "$name/bin/activate"
  else
    echo "vrun: no venv found at ./$name" >&2
    return 1
  fi
}

# =============================================================================
# tmux — oh-my-zsh tmux plugin aliases
# =============================================================================
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# =============================================================================
# Personal config (carried over from the old .zshrc)
# =============================================================================

# command for using git for dotfiles
function config {
  /usr/bin/git --git-dir="$HOME/.myconf" --work-tree="$HOME" "$@"
}

[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
