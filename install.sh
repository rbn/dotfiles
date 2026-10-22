#!/usr/bin/env bash

set -e

# Identify the Linux distribution
source /etc/os-release

echo "Detected Linux distribution: $ID"#!/usr/bin/env bash

set -e

# Identify the Linux distribution
source /etc/os-release

echo "Detected Linux distribution: $ID"

case "$ID" in
    ubuntu|debian)
        PKG_MANAGER="apt"
        ;;
    fedora)
        PKG_MANAGER="dnf"
        ;;
    *)
        echo "Unsupported distribution: $ID"
        exit 1
        ;;
esac

echo "Package manager: $PKG_MANAGER"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mapfile -t PACKAGES < "$SCRIPT_DIR/packages/common.txt"

printf 'Packages to install:\n'
printf '  %s\n' "${PACKAGES[@]}"

DISTRO_FILE="$SCRIPT_DIR/packages/$ID.txt"

if [[ -f "$DISTRO_FILE" ]]; then
    mapfile -t DISTRO_PACKAGES < "$DISTRO_FILE"
    PACKAGES+=("${DISTRO_PACKAGES[@]}")
fi

echo
read -rp "Install these packages? [y/N] " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Installation cancelled."
    exit 0
fi

case "$PKG_MANAGER" in
    apt)
        sudo apt update
        sudo apt install -y "${PACKAGES[@]}"
        ;;
    dnf)
        sudo dnf install -y "${PACKAGES[@]}"
        ;;
esac
