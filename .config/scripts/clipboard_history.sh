#!/bin/zsh

selection=$(
    cliphist list |  # Get cliphist items
    fzf -d $'\t' --with-nth 2 |  # Don't display entry IDs
    cliphist decode  # Get the original entry from the database
)

if [ -n "$selection" ]; then  # If a selection was made, copy to clipboard.
    echo -n "$selection" | nohup wl-copy >/dev/null 2>&1
fi
