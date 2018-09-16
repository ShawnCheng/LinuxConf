#!/usr/bin/env zsh

local user_char="%{$fg_bold[green]%}➜ %{$reset_color%}"
local root_user_char="%{$fg_bold[red]%}⚡%{$reset_color%}"
local ret_status="%(?:%{$fg_bold[green]%}%{$reset_color%}:%{$fg_bold[red]%}:(%{$reset_color%})"

PROMPT='$(prompt_symbol) '
RPROMPT='${ret_status}'

# Output additional information about user/host, paths and repos
precmd() {
    if [[ $EUID -eq 0 ]]; then
        print -P '${root_user_char}%{$fg[red]%}%n@%m%{$reset_color%} %{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)'
    else
        print -P '${user_char}%{$fg[green]%}%n@%m%{$reset_color%} %{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)'
    fi
}

prompt_symbol() {
    local prompt_color
    local prompt_char
    if [[ $EUID -eq 0 ]]; then
        prompt_color="%{$fg[red]%}"
        prompt_char="#"
    else
        prompt_color="%{$fg[green]%}"
        prompt_char="$"
    fi
    git branch >/dev/null 2>/dev/null && print -P '${prompt_color}±%{$reset_color%}' && return
    print -P '${prompt_color}${prompt_char}%{$reset_color%}' && return
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}) %{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%}) %{$fg[green]%}✔"
