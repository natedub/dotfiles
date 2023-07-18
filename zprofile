eval "$(/opt/homebrew/bin/brew shellenv)"

if type pyenv > /dev/null; then
  eval "$(pyenv init --path)"
  eval "$(pyenv virtualenv-init -)"
fi
