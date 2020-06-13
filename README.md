# `aether`

This is my repository of configuration scripts that I use to manage my machines.

You're welcome to use these as a starting point for your own configuration, but
some of these settings are highly tailored to how I like to work. YMMV.

## Naming

[Aether](https://en.wikipedia.org/wiki/Aether_(mythology)) was the son of Erebus
(Darkness) and Nyx (Night).

Aether is also the personification of the upper sky, as opposed to the normal
air (aer) breathed by mortals.

## Setup

1. Clone this to `/usr/local/aether`
2. Install nix
3. Install nix-darwin
4. Run `darwin-rebuild switch -I darwin-config=/usr/local/aether/etc/nix/darwin.nix`
