# tmux.conf
My tmux configuration.

## Install tmux

```shell
# OSX
brew install tmux

# Ubuntu/Debian
sudo apt install tmux -y
```

```shell
git clone https://github.com/iliubang/tmux.conf.git ~/.tmux
ln -s ~/.tmux/tmux.conf ~/.tmux.conf
```

## Install plugins

```shell
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Press `prefix` + `I` (capital I, as in Install) to fetch the plugin.

Press `prefix` + `U` to updates plugin(s)

Press `prefix` + `alt` + `u` to remove/uninstall plugins not on the plugin list
