# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Source private credentials safely if the file exists
if [ -f ~/.bash_secrets ]; then
  source ~/.bash_secrets
fi
# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc
. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# bun
if [ -d "$HOME/.bun/bin" ] && [[ ":$PATH:" != *":$HOME/.bun/bin:"* ]]; then
  PATH="$HOME/.bun/bin:$PATH"
fi

. "$HOME/.local/bin/env"

export PATH="/var/home/l/.local/bin:$PATH"
export IBUS_COMPONENT_PATH="$HOME/.local/share/ibus/component:$IBUS_COMPONENT_PATH"
export IBUS_COMPONENT_PATH="$HOME/.local/share/ibus/component:$IBUS_COMPONENT_PATH"
export PATH="/usr/libexec:$PATH"
