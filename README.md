# Homebrew Tap

Homebrew formulae maintained by [sorafujitani](https://github.com/sorafujitani).

## zshctl

Install the stable tagged release:

```sh
brew install sorafujitani/tap/zshctl
```

Add the Zsh integration to `~/.zshrc`:

```zsh
source "$(brew --prefix)/share/zshctl/zshctl.zsh"
zshctl-bind-default-keys
```

Open a new shell and verify it:

```sh
zshctl server status
```

The Formula installs `zshctl`, `zshctld`, and the runtime dependencies `fzf`
and `ghq`. See the [zshctl repository](https://github.com/sorafujitani/zshctl)
for configuration, key bindings, migration, and release documentation.

To build the latest `main` branch instead of a tagged release:

```sh
brew install --HEAD sorafujitani/tap/zshctl
```

## linearctl

```sh
brew install sorafujitani/tap/linearctl
```

See the [linearctl repository](https://github.com/sorafujitani/linearctl) for
configuration and usage.
