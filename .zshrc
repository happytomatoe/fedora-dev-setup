# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

### Custom
zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions 

zinit ice depth=1
zinit light mroth/evalcache


zi ice from"gh-r" as"program"
zi light junegunn/fzf

zi ice from"gh-r" as"program" mv"docker* -> docker-compose" bpick"*linux*"
zi load docker/compose
zi snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/alias-finder/alias-finder.plugin.zsh 
zi snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/dnf/dnf.plugin.zsh
zi snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/docker-compose/docker-compose.plugin.zsh
zi snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh
#zi snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/hitchhiker/hitchhiker.plugin.zsh
zi snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh
zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/git/git.plugin.zsh'
#zinit snippet 'https://gist.github.com/hightemp/5071909'

zinit ice depth=1;
zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zinit light NICHOLAS85/z-a-eval
zinit ice as"command" from"gh-r" mv"zoxide* -> zoxide" \
      eval"./zoxide init zsh"
zinit light ajeetdsouza/zoxide

zinit ice atclone"dircolors -b LS_COLORS > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS


alias pbcopy='xclip -selection clipboard'

. "$HOME/.atuin/bin/env"

_evalcache atuin init zsh

if [[ -z "$ZELLIJ" ]]; then
    if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
        zellij attach -c
    else
        zellij
    fi

    if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
        exit
    fi
fi

# vi mode
export EDITOR=nvim
export VISUAL=$EDITOR


zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
function zvm_after_lazy_keybindings() {
  # Bind Alt+RightArrow to forward-word in insert mode
  zvm_bindkey viins '\e[1;3C' forward-word
  # Bind Alt+LeftArrow to backward-word in insert mode
  zvm_bindkey viins '\e[1;3D' backward-word
}

# sharkdp/fd
zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

# sharkdp/bat
zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

# terminal keywords hhighlighter
zinit ice pick"h.sh"
zinit light paoloantinori/hhighlighter

alias n='nvim'
