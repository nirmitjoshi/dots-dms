#!/usr/bin/env zsh

hide_cursor=$'\e[?25l'
show_cursor=$'\e[?25h'
reset=$'\e[0m'
blue=$'\e[38;2;137;180;250m'
lavender=$'\e[38;2;180;190;254m'
green=$'\e[38;2;166;227;161m'
dim=$'\e[38;2;108;112;134m'

printf '%s' "$hide_cursor"
trap 'printf "%s" "$show_cursor$reset"' EXIT INT TERM

clear
printf '  %sZellij keys%s\n' "$blue" "$reset"

printf '  %sPane mode %s(Ctrl p)%s\n' "$lavender" "$dim" "$reset"
printf '    %sh/j/k/l%s focus  %sn%s new  %sd%s down  %sr%s right  %ss%s stack\n' "$green" "$reset" "$green" "$reset" "$green" "$reset" "$green" "$reset" "$green" "$reset"
printf '    %sf%s fullscreen  %sc%s rename  %sx%s close  %sw%s floats  %se%s float/embed\n' "$green" "$reset" "$green" "$reset" "$green" "$reset" "$green" "$reset" "$green" "$reset"

printf '  %sTab mode %s(Ctrl t)%s\n' "$lavender" "$dim" "$reset"
printf '    %sn%s new  %sr%s rename  %sh/l%s prev/next  %s1-9%s jump  %sx%s close\n' "$green" "$reset" "$green" "$reset" "$green" "$reset" "$green" "$reset" "$green" "$reset"

printf '  %sResize mode %s(Ctrl n)%s\n' "$lavender" "$dim" "$reset"
printf '    %sh/j/k/l%s resize edges  %s+ / -%s grow/shrink\n' "$green" "$reset" "$green" "$reset"

printf '  %sScroll mode %s(Ctrl s)%s\n' "$lavender" "$dim" "$reset"
printf '    %sj/k%s scroll  %sd/u%s half page  %ss%s search  %se%s edit\n' "$green" "$reset" "$green" "$reset" "$green" "$reset" "$green" "$reset"

printf '  %sSearch mode %s(Ctrl s, then s)%s\n' "$lavender" "$dim" "$reset"
printf '    %sn/p%s next/prev  %sc/w/o%s case/wrap/whole-word\n' "$green" "$reset" "$green" "$reset"

printf '  %sSession mode %s(Ctrl o)%s\n' "$lavender" "$dim" "$reset"
printf '    %sw%s manager  %sd%s detach  %sc/p/l%s config/plugin/layout\n' "$green" "$reset" "$green" "$reset" "$green" "$reset"

printf '  %sMove mode %s(Ctrl h)%s\n' "$lavender" "$dim" "$reset"
printf '    %sh/j/k/l%s move pane  %sn / p%s rotate panes\n' "$green" "$reset" "$green" "$reset"

printf '  %sCustom%s\n' "$lavender" "$reset"
printf '    %s?%s help  %sAlt Space%s floating shell  %sCtrl y%s room\n' "$green" "$reset" "$green" "$reset" "$green" "$reset"

printf '  %sEsc / Enter closes this pane.%s\n' "$dim" "$reset"

while true; do
    IFS= read -rs -k 1 key || break
    [[ "$key" == $'\e' || "$key" == $'\n' || "$key" == $'\r' ]] && break
done
