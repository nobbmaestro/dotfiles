# Terminfo configuration

This aspect manages `TERMINFO` files that add escape sequences for italic, and overwrite conflicting sequences for standout text.

To check that the terminal does the right thing:

```sh
echo `tput sitm`italics`tput ritm` `tput smso`standout`tput rmso`
```

## References

- [Enabling Italic Text in iTerm2 and Tmux](https://weibeld.net/terminals-and-shells/italics.html)
