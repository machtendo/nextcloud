#! /bin/bash
mkdir -p ~/.dotfiles

# Move Configuration Files to 'dotfiles'

    # NixOS Configuration Files
    echo "Moving NixOS Configuration Files..."

    sudo mv /etc/nixos/configuration.nix ~/.dotfiles/nixos/configuration.nix
    sudo mv /etc/nixos/hardware-configuration.nix ~/.dotfiles/nixos/hardware-configuration.nix

    # NixOS Home Manager Configuration Files
    echo "Moving Home Manager Configuration Files..."

    mv ~/.config/home-manager/home.nix ~/.dotfiles/nixos/home.nix
    mv ~/.config/home-manager/flake.nix ~/.dotfiles/nixos/flake.nix
    mv ~/.config/home-manager/flake.lock ~/.dotfiles/nixos/flake.lock
