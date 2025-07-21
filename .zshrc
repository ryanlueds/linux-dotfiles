# ------------------------------ LOOK COOL  -----------------------------------
autoload -U colors && colors

PROMPT='[%n@%F{red}tetOS%f %~]$ %f'

# eza n't this the coolest
alias ls="eza --color=always --grid --git --no-filesize --icons=always --no-time --no-user --no-permissions --all --long"
alias tree='eza --tree --git-ignore'

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# --------------------------------- CONDA  --------------------------------------
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ryan/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ryan/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ryan/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ryan/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# ------------------------- NODE VERSION MANAGER ---------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



# place this after nvm initialization!
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc


# ------------------------- CONVENIENT ---------------------------------
alias vencord='sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"'
alias startpage='cd ~/.config/startpage && python -m http.server 6969'
