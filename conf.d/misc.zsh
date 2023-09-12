#
# misc - Set general Zsh config options here, or change plugin settings.
#


#
# Options
#

# Fix/reset bad plugin options.
setopt NO_BEEP       # Be quiet!
setopt NO_HIST_BEEP  # Be quiet!


#
# antidote
#

[[ -n "$ANTIDOTE_HOME" ]] || ANTIDOTE_HOME="$(antidote home)"

#
# git
#
# gcrbm: git checkout and rebase a branch on git_main_branch then checkout again git_main_branch
function gcrbm() {
  git checkout $1 && git rebase $(git_main_branch) && git checkout $(git_main_branch)
}
compdef _git gcrbm=git-checkout

# gcrbmf: like gcrbm but push force before coming back to git_main_branch
function gcrbmf() {
  git checkout $1 && git rebase $(git_main_branch) && git push --force-with-lease && git checkout $(git_main_branch)
}
compdef _git gcrbmf=git-checkout

# Jump
eval "$(jump shell)"

# The Fuck
eval $(thefuck --alias)

# nvm
autoload -U add-zsh-hook
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# hf cli
# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

HF_AC_ZSH_SETUP_PATH=/Users/ludovic/Library/Caches/@hinfact/cli/autocomplete/zsh_setup && test -f $HF_AC_ZSH_SETUP_PATH && source $HF_AC_ZSH_SETUP_PATH; # hf autocomplete setup

#
# keybindings
#
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
