#!/usr/bin/env zsh

hide_cursor=$'\e[?25l'
show_cursor=$'\e[?25h'
reset=$'\e[0m'
bold=$'\e[1m'
dim=$'\e[2m'
title=$'\e[38;2;137;180;250m'
section_color=$'\e[38;2;180;190;254m'
key_color=$'\e[38;2;166;227;161m'
muted=$'\e[38;2;108;112;134m'

printf '%s' "$hide_cursor"
trap 'printf "%s" "$show_cursor$reset"' EXIT INT TERM

rule() {
    printf '  %s%s%s\n' "$muted" '--------------------------------------------------------------------------------' "$reset"
}

head_pair() {
    printf '\n  %s%-38s%s  %s%-38s%s\n' "$section_color$bold" "$1" "$reset" "$section_color$bold" "$2" "$reset"
}

row_pair() {
    printf '  %s%-13s%s %-24s  %s%-13s%s %-24s\n' "$key_color" "$1" "$reset" "$2" "$key_color" "$3" "$reset" "$4"
}

clear
printf '\n  %s%sZellij cheat sheet%s  %s(q, Esc, or Enter closes)%s\n' "$title" "$bold" "$reset" "$dim" "$reset"
rule

head_pair 'Global shortcuts' 'Custom and plugins'
row_pair 'Ctrl g' 'lock / unlock input' 'F1' 'open this help'
row_pair 'Ctrl q' 'quit session' 'Alt Space' 'floating scratch shell'
row_pair 'Alt n' 'new pane' 'Ctrl y' 'room plugin'
row_pair 'Alt f' 'toggle floating panes' '' ''
row_pair 'Alt h/j/k/l' 'focus left/down/up/right' '' ''
row_pair 'Alt arrows' 'focus or tab by edge' '' ''
row_pair 'Alt +/-' 'resize focused pane' '' ''
row_pair 'Alt [/]' 'prev / next layout' '' ''
row_pair 'Alt i/o' 'move tab left / right' '' ''
row_pair 'Alt p' 'toggle pane group' '' ''
row_pair 'Alt Shift p' 'toggle group marking' '' ''

head_pair 'Pane mode (Ctrl p)' 'Tab mode (Ctrl t)'
row_pair 'h/j/k/l' 'focus pane' 'n' 'new tab'
row_pair 'p' 'switch focus' 'x' 'close tab'
row_pair 'n' 'new pane' 'r' 'rename tab'
row_pair 'd / r' 'new down / right' 'h/l/arrows' 'prev / next tab'
row_pair 's' 'new stacked pane' '1-9' 'jump to tab'
row_pair 'x' 'close pane' 's' 'sync input'
row_pair 'f' 'fullscreen pane' 'b' 'break pane to tab'
row_pair 'z' 'toggle frames' '[ / ]' 'break pane left/right'
row_pair 'w' 'toggle floats' 'Tab' 'last active tab'
row_pair 'e' 'embed / float pane' '' ''
row_pair 'c' 'rename pane' '' ''
row_pair 'i' 'pin floating pane' '' ''

head_pair 'Resize mode (Ctrl n)' 'Scroll/Search (Ctrl s)'
row_pair 'h/j/k/l' 'grow border direction' 'j/k/arrows' 'scroll down / up'
row_pair 'H/J/K/L' 'shrink border direction' 'Ctrl f/PgDn' 'page down'
row_pair '+ / =' 'grow focused pane' 'Ctrl b/PgUp' 'page up'
row_pair '-' 'shrink focused pane' 'd / u' 'half page down / up'
row_pair '' '' 'e' 'edit scrollback'
row_pair '' '' 's' 'start search'
row_pair '' '' 'Enter' 'confirm search'
row_pair '' '' 'n / p' 'next / previous match'
row_pair '' '' 'c / w / o' 'case / wrap / word'
row_pair '' '' 'Ctrl c' 'bottom and exit'

head_pair 'Session mode (Ctrl o)' 'Move mode (Ctrl h)'
row_pair 'w' 'session manager' 'h/j/k/l' 'move pane'
row_pair 'd' 'detach' 'n / Tab' 'rotate forward'
row_pair 'c' 'configuration' 'p' 'rotate backward'
row_pair 'p' 'plugin manager' '' ''
row_pair 'l' 'layout manager' '' ''
row_pair 'a' 'about' '' ''
row_pair 's' 'share' '' ''

head_pair 'Tmux mode (Ctrl b)' ''
row_pair '% / "' 'split right / down' '' ''
row_pair 'c' 'new tab' '' ''
row_pair ',' 'rename tab' '' ''
row_pair 'x' 'close pane' '' ''
row_pair 'p / n' 'prev / next tab' '' ''
row_pair 'z' 'fullscreen pane' '' ''
row_pair 'd' 'detach' '' ''
row_pair '[' 'scroll mode' '' ''

while true; do
    IFS= read -rs -k 1 key || break
    [[ "$key" == "q" || "$key" == $'\e' || "$key" == $'\n' || "$key" == $'\r' ]] && break
done
