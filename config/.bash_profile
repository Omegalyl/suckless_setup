# ~/.bash_profile — login shell setup
# Also sourced by ly (/etc/ly/setup.sh) before ~/.xinitrc runs, so anything
# exported here is visible to dwm, dmenu and keybind-spawned scripts.
# Keep it silent: no output, no prompts.

# PATH: ~/bin holds the repo scripts (powermenu, wifimenu, scrot-s, ...)
for d in "$HOME/.local/bin" "$HOME/bin"; do
    case ":$PATH:" in
        *":$d:"*) ;;
        *) [ -d "$d" ] && PATH="$d:$PATH" ;;
    esac
done
export PATH

export EDITOR=vim
export VISUAL=vim
export PAGER=less
export LESS='-R'
export TERMINAL=kitty
export BROWSER=firefox

# XDG base dirs (ly writes its session log to ~/.local/state)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
mkdir -p "$XDG_STATE_HOME" 2>/dev/null

# Interactive settings live in .bashrc
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
