# Kitty icon config

On macOS and X11 you can put kitty.app.icns (macOS only) or kitty.app.png in the kitty configuration directory, and
this icon will be applied automatically at startup. On X11, this will set the icon for kitty windows.

Unfortunately, on macOS, Apple’s Dock does not change its cached icon so the custom icon will revert when kitty is
quit. Run the following to force the Dock to update its cached icons:

```sh
rm /var/folders/_/_/\*/com.apple.dock.iconcache; killall Dock
```

Note, you may need to reboot your system.

Read more on [https://sw.kovidgoyal.net/kitty/faq/#i-do-not-like-the-kitty-icon](https://sw.kovidgoyal.net/kitty/faq/#i-do-not-like-the-kitty-icon)
