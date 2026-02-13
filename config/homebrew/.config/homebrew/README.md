# Homebrew

## Using brew in a multi-user system

```sh
# ~.zshrc
unalias brew 2>/dev/null
brewser=$(stat -f "%Su" $(which brew))
alias brew='sudo -Hu '$brewser' brew'
```

Reference: [Using brew in a multi-user system](https://dev.to/cerico/using-brew-in-a-multi-user-system-2lnl)
