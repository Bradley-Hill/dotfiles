# ==============================================================================
# OH MY ZSH CORE CONFIGURATION
# ==============================================================================

export ZSH="$HOME/.oh-my-zsh"

# Enable Powerlevel10k Instant Prompt for fast shell startup
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Theme: Powerlevel10k (Replaces agnoster)
ZSH_THEME="powerlevel10k/powerlevel10k"

# Automatic update settings
zstyle ':omz:update' mode auto

# History timestamp format
HIST_STAMPS="yyyy-mm-dd"

# Enable useful completion settings
COMPLETION_WAITING_DOTS="true"

# ==============================================================================
# PLUGINS
# ==============================================================================
# Note: zsh-syntax-highlighting MUST remain the last plugin in the list.
plugins=(
  git
  sudo
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ==============================================================================
# ALIASES & MODERN CLI ENHANCEMENTS
# ==============================================================================

# Modern replacement aliases (fallback to standard if not installed)
if command -v eza &> /dev/null; then
  alias ls="eza --icons --group-directories-first"
  alias ll="eza -la --icons --git"
  alias tree="eza --tree --icons"
fi

if command -v bat &> /dev/null; then
  alias cat="bat"
fi

# Custom Aliases
if [ -f "$HOME/.zsh_aliases" ]; then
  source "$HOME/.zsh_aliases"
fi

# Custom Functions
if [ -f "$ZSH/custom/.zsh_functions" ]; then
  source "$ZSH/custom/.zsh_functions"
fi

# ==============================================================================
# ENVIRONMENT & TOOL INTEGRATIONS
# ==============================================================================

# Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Scalingo CLI Autocompletion
# if [ -f "$HOME/.zsh/completion/scalingo_complete.zsh" ]; then
#   source "$HOME/.zsh/completion/scalingo_complete.zsh"
# fi

# Powerlevel10k configuration file load
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh