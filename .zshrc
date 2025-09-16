# Zsh History Configuration
HISTFILE=~/.dotfiles/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# History options
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry
setopt HIST_VERIFY               # Show command with history expansion to user before running it
setopt APPEND_HISTORY            # Append history to the history file (no overwriting)
setopt SHARE_HISTORY             # Share history across terminals
setopt INC_APPEND_HISTORY        # Immediately append to the history file, not just when a term is killed

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


# Plugins section

# Tema Powerlevel10k
zi ice depth=1 quiet nocd
zi light romkatv/powerlevel10k

#zi light babarot/enhancd

# Plugins esenciales de OMZ (carga diferida con turbo mode)
zi snippet OMZL::key-bindings.zsh
zi snippet OMZL::completion.zsh
zi snippet OMZL::clipboard.zsh
zi snippet OMZL::git.zsh

# Plugins de productividad (carga diferida)
zi wait lucid light-mode for \
    atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
    zdharma-continuum/fast-syntax-highlighting \
    zsh-users/zsh-completions \
    zsh-users/zsh-history-substring-search \
    MichaelAquilina/zsh-you-should-use

# Plugins específicos de OMZ (snippets)
zi snippet OMZP::archlinux
zi snippet OMZP::docker
zi snippet OMZP::docker-compose
#zi snippet OMZP::dotnet
zi snippet OMZP::eza
#zi snippet OMZP::fnm
#zi snippet OMZP::fzf
zi snippet OMZP::git
zi snippet OMZP::history
#    OMZP::ng
#    OMZP::npm
#    OMZP::oc
#    OMZP::podman
#    OMZP::qrcode
#    OMZP::rsync
zi snippet OMZP::sudo

# Own aliases
zi snippet ~/.zsh_plugins/own-aliases.plugin.zsh

# End plugin section


# Configuración de completions
autoload -Uz compinit
compinit

# Prompt instantáneo de Powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Cargar configuración de Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zoxide
eval "$(zoxide init zsh)"

# fnm
FNM_PATH="/home/leohasa/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi
