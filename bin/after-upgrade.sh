#!/usr/bin/env bash

sudo mv /etc/zshenv   /etc/zshenv.bak.before_nix_darwin
sudo mv /etc/zshrc    /etc/zshrc.bak.before_nix_darwin
sudo mv /etc/zprofile /etc/zprofile.bak.before_nix_darwin
sudo mv /etc/shells   /etc/shells.bak.before_nix_darwin

sudo /nix/var/nix/profiles/system/activate
