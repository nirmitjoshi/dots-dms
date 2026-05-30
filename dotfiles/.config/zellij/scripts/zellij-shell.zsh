#!/usr/bin/env zsh

if [[ -n "${ZELLIJ_SESSION_NAME:-}" ]]; then
    lock="/tmp/zellij-${ZELLIJ_SESSION_NAME}-$$"
    touch "$lock"
    trap 'rm -f "$lock"' EXIT
fi

"${ZELLIJ_REAL_SHELL:-/usr/bin/zsh}" -i
status=$?

if [[ -n "${ZELLIJ_SESSION_NAME:-}" ]]; then
    rm -f "$lock"
    remaining=$(ls /tmp/zellij-${ZELLIJ_SESSION_NAME}-* 2>/dev/null | wc -l)
    if [[ "$remaining" -eq 0 ]]; then
        zellij kill-session "$ZELLIJ_SESSION_NAME" >/dev/null 2>&1 &
        disown
    fi
fi

exit "$status"
