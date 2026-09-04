# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#!/bin/zsh
#
# zprof
#

# Load zprof first if we need to profile.
[[ ${ZPROFRC:-0} -eq 0 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

#
# Essentials
#

# Don't trust plugin managers to load this because if my .zshrc breaks after this, I'd
# like at least this much to work.
[[ -f $ZDOTDIR/plugins/essentials/essentials.plugin.zsh ]] && . $ZDOTDIR/plugins/essentials/essentials.plugin.zsh


#
# zstyles
#

[[ -f $ZDOTDIR/.zstyles ]] && source $ZDOTDIR/.zstyles

#
# compinit
#
autoload -Uz compinit
compinit

#
# antidote
#

ANTIDOTE_HOME=$ZDOTDIR/plugins/.external

# Clone antidote if necessary.
[[ -e $ZDOTDIR/.antidote ]] ||
  git clone --depth=1 https://github.com/mattmc3/antidote.git $ZDOTDIR/.antidote

# Set the name of the static .zsh plugins file antidote will generate.
zsh_plugins=${ZDOTDIR:-~}/.zplugins.zsh

# Ensure you have a .zsh_plugins.txt file where you can add plugins.
[[ -f ${zsh_plugins:r}.txt ]] || touch ${zsh_plugins:r}.txt

# Lazy-load antidote.
fpath+=(${ZDOTDIR:-~}/.antidote/functions)
autoload -Uz $fpath[-1]/antidote

# Expand $VARs in .zplugins.txt (so `$ZDOTDIR/plugins/foo` lines resolve).
# Pure zsh, so we don't depend on gettext's envsubst being installed.
.zplugins-expand() {
  local line
  while IFS= read -r line; do print -r -- ${(e)line}; done <${zsh_plugins:r}.txt
}

# Generate static file in a subshell when .zsh_plugins.txt is updated.
if [[ ! $zsh_plugins -nt ${zsh_plugins:r}.txt ]] || [[ ! -s $zsh_plugins ]]; then
  source $ZDOTDIR/.antidote/antidote.zsh
  (.zplugins-expand | antidote bundle >|$zsh_plugins)
fi

# Source your static plugins file.
source $zsh_plugins


#
# Local
#

# Local settings/overrides
[[ -f $ZDOTDIR/.zshrc_local ]] && source $ZDOTDIR/.zshrc_local


#
# Wrap up
#

# Done profiling.
[[ ${ZPROFRC:-0} -eq 0 ]] || { unset ZPROFRC && zprof }
true

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# Guarded so this is a no-op on hosts without miniconda installed.
if [ -d "$HOME/miniconda3" ]; then
    __conda_setup="$("$HOME/miniconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
            . "$HOME/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="$HOME/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    conda deactivate
fi
# <<< conda initialize <<<


# pnpm
export PNPM_HOME="/Users/ludovicsterlin/.config/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Created by `pipx` on 2024-01-04 09:31:55
export PATH="$PATH:/Users/ludovicsterlin/.local/bin"

# Latex
export PATH="$PATH:/Library/TeX/texbin"

# Go
export PATH="$HOME/go/bin:$PATH"
export PATH=$PATH:/Users/ludovicsterlin/src/alan-apps/extra-tools/bin
