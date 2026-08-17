# Homebrew Tap

Homebrew formulae maintained by [sorafujitani](https://github.com/sorafujitani).

## linearctl

Install directly from the tap:

```sh
brew install sorafujitani/tap/linearctl
```

Or add the tap first and use the short formula name:

```sh
brew tap sorafujitani/tap
brew install linearctl
```

## hermes

Install Hermes, a Rust-native stateful shell workflow toolkit for Zsh:

```sh
brew install sorafujitani/tap/hermes
```

Or add the tap first and use the short formula name:

```sh
brew tap sorafujitani/tap
brew install hermes
```

After installation, add the loader and key bindings to `~/.zshrc`:

```zsh
source "$(brew --prefix)/share/hermes/hermes.zsh"
hermes-bind-default-keys
```

The formula installs `hermes`, `hermesd`, and the runtime dependencies `fzf`
and `ghq`.

To build the latest `main` branch:

```sh
brew install --HEAD sorafujitani/tap/linearctl
```

See the [linearctl repository](https://github.com/sorafujitani/linearctl) for configuration and usage.
