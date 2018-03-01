# Link

```
cd ~
for f in $(ls -d .dotfiles/link/.*); do ln -s $f /target; done && ls -al /target
```
