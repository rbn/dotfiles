#!/usr/bin/env bash

REPO="$HOME/dotfiles"

cd "$REPO" || exit 1

if [[ -n "$(git status --porcelain)" ]]; then
    echo "Dotfiles have uncommitted changes."
    echo "Run: cd ~/dotfiles && git status"
fi
