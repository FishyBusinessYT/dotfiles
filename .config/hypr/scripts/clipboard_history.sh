#!/bin/zsh
selection=$(cliphist list | fzf --no-sort | cliphist decode)

if [ -n "$selection" ]; then
	echo -n "$selection" | nohup wl-copy >/dev/null 2>&1
fi
