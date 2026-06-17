#!/bin/bash
# Wraps i3status and prepends a Claude usage-limits block (i3bar JSON protocol).
# Usage data comes from the same endpoint Claude Code's /usage uses, with the
# OAuth token from ~/.claude/.credentials.json. Cached to avoid hammering the API.

CACHE=${XDG_RUNTIME_DIR:-/tmp}/claude-usage.json
CACHE_TTL=60

claude_block() {
    local now mtime token
    now=$(date +%s)
    mtime=$(stat -c %Y "$CACHE" 2>/dev/null || echo 0)
    if (( now - mtime > CACHE_TTL )); then
        # touch first so a failing endpoint isn't retried every bar tick
        touch "$CACHE"
        token=$(jq -r '.claudeAiOauth.accessToken // empty' ~/.claude/.credentials.json 2>/dev/null)
        if [[ -n $token ]]; then
            curl -sf -m 5 https://api.anthropic.com/api/oauth/usage \
                -H "Authorization: Bearer $token" \
                -H "anthropic-beta: oauth-2025-04-20" \
                -o "$CACHE.tmp" 2>/dev/null && mv "$CACHE.tmp" "$CACHE"
        fi
    fi

    local five seven resets_at
    five=$(jq -r '.five_hour.utilization // empty' "$CACHE" 2>/dev/null)
    seven=$(jq -r '.seven_day.utilization // empty' "$CACHE" 2>/dev/null)
    resets_at=$(jq -r '.five_hour.resets_at // empty' "$CACHE" 2>/dev/null)
    if [[ -z $five || -z $seven ]]; then
        printf '{"name":"claude","full_text":" claude ?? ","color":"#586E75"}'
        return
    fi

    # truncate decimals; printf %.0f breaks under comma-decimal locales
    five=${five%%.*}
    seven=${seven%%.*}

    # time remaining until the 5-hour window resets, as "1h23m"
    local countdown="" reset_epoch left
    reset_epoch=$(date -d "$resets_at" +%s 2>/dev/null)
    if [[ -n $reset_epoch ]]; then
        left=$(( reset_epoch - $(date +%s) ))
        if (( left > 0 )); then
            if (( left >= 3600 )); then
                countdown=$(printf ' (%dh%02dm)' $((left / 3600)) $((left % 3600 / 60)))
            else
                countdown=$(printf ' (%dm)' $((left / 60)))
            fi
        fi
    fi

    local worst=$(( five > seven ? five : seven ))
    local color="#2AA198"
    (( worst >= 70 )) && color="#B58900"
    (( worst >= 90 )) && color="#DC322F"
    printf '{"name":"claude","full_text":" claude 5h:%s%%%s 7d:%s%% ","color":"%s"}' \
        "$five" "$countdown" "$seven" "$color"
}

exec i3status -c "$HOME/.config/i3status/config" | (
    IFS= read -r header && printf '%s\n' "$header"
    IFS= read -r open && printf '%s\n' "$open"
    while IFS= read -r line; do
        prefix=""
        [[ $line == ,* ]] && { prefix=","; line=${line#,}; }
        printf '%s[%s,%s\n' "$prefix" "$(claude_block)" "${line#[}"
    done
)
