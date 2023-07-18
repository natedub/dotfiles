# Autocomplete
# --------------
autoload -Uz compinit add-zsh-hook
compinit

# case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# default to file completion
zstyle ':completion:*' completer _expand _complete _files _correct _approximate
zstyle ':completion:*' verbose yes
#zstyle ':completion:*:descriptions' format '%B%d%b'  # NOTE: bold formatting does not work
zstyle ':completion:*:descriptions' format '%d'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# Theme
# --------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zsh-plugins/powerlevel10k/powerlevel10k.zsh-theme

# Plugins
# --------------

source ~/.zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh-plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh-plugins/zsh-npm-scripts-autocomplete/zsh-npm-scripts-autocomplete.plugin.zsh
source ~/.zsh-plugins/fzf-tab/fzf-tab.plugin.zsh

# Key bindings
# --------------
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Environment
# --------------

if type pyenv > /dev/null; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if type direnv > /dev/null; then
  eval "$(direnv hook zsh)"
fi

if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd)"
fi


export PIP_REQUIRE_VIRTUALENV=true
export VIRTUAL_ENV_DISABLE_PROMPT=1

export EDITOR=vim
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export TSC_WATCHFILE=UseFsEvent

export KEYTIMEOUT=1              # keybind vi defaults to 0.4s delay switching modes, reduce to 0.1

HISTSIZE=10000000
SAVEHIST=10000000
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
setopt INTERACTIVE_COMMENTS      # Parse hash as a comment on the CLI

alias qgit='qgit --branches --remotes --since="6 months ago" &> /dev/null &|'

alias gitst="git status --column=auto"
alias gitc="git commit"
alias gitcam='git commit --amend -C HEAD'
alias gitd="git diff"
#alias gitdi="vim -c Gdiff"
alias gitrb="git rebase"
alias gitrbi="git rebase --autosquash -i"
alias gitrbic="git rebase -i \`git merge-base origin/master head\`"
alias gitrba="git rebase --abort"
alias gitrbc="git rebase --continue"
alias gitrbs="git rebase --skip"
alias gitrbo="git rebase --onto"
#alias gitsrc="git show \`head -n 1 .git/rebase-apply/patch\`"
alias gitco="git checkout"
alias gitcp="git cherry-pick"
alias gitbr="git branch"
alias gitf="git fetch"
alias gita="git add"
alias gitai="git add -i"
alias gitstg='git diff --cached'
alias gitap="git add -p"
alias gitmv="git mv"
alias gitrm="git rm"
alias gitmf="git merge --ff-only"
alias gitmg="git merge --no-ff"
alias gitmm="CURRENT_BRANCH=\`git rev-parse --abbrev-ref HEAD\`; git checkout master && git merge --no-ff \$CURRENT_BRANCH"
alias gitsth="git stash"
alias gitrst="git reset"
alias gitpo="git push origin"
alias gitpocurr='git push origin `git rev-parse --abbrev-ref HEAD`'
alias gitgrep="git grep -I -n --break --heading"
alias gitgrepo="git grep -I -n -Ovi"
alias gitres="git grep -I -n -Ovi '<<<<<<<'"
alias gitresd="git status --porcelain | grep -E '^(UU|AA) ' | awk '{print \$2}' | xargs git add"
#alias gitlg='git log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --'

gitcleanup() {
	git remote prune origin;
	for x in `git branch --merged origin/master | grep -v master`; do git branch -d $x; done;
	for x in `git branch -r --merged origin/master | grep -v master | grep -v production | awk '{print(substr($1, 8))}'`; do git push origin :$x; done;
}
gitfo() {
	echo git add $1 && git reset HEAD $1 || git checkout $1;
}

if [[ -e ~/.profilelocal ]]; then
  source ~/.profilelocal
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
