# `aether`

This is my repository of configuration scripts that I use to manage my machines.

You're welcome to use these as a starting point for your own configuration, but
some of these settings are highly tailored to how I like to work. YMMV.

## Naming

[Aether](<https://en.wikipedia.org/wiki/Aether_(mythology)>) was the son of Erebus
(Darkness) and Nyx (Night).

Aether is also the personification of the upper sky, as opposed to the normal
air (aer) breathed by mortals.

## Setup

1. Clone this to `/usr/local/aether`
2. Install nix
3. Install nix-darwin
4. Run `env TERM=xterm-256color darwin-rebuild switch -I darwin-config=/usr/local/aether/etc/nix/darwin.nix`

See [this issue](https://github.com/nix-community/home-manager/issues/423#issuecomment-748387272)
for background on why specifying `TERM` is necessary.

After the first-time setup, it is no longer necessary to specify `-I`.

## macOS Upgrades

Upgrading macOS will cause some configuration from nix-darwin to be reset. After
upgrading, run the `bin/after-upgrade.sh` script to reactivate nix-darwin.
