# Program shortcuts
abbr -a cz chezmoi
abbr -a py python

# Chezmoi shortcuts
abbr -a cza chezmoi git -- add
abbr -a czc chezmoi git -- commit -v
abbr -a czp chezmoi git -- push
abbr -a czs chezmoi git -- status
abbr -a czd chezmoi git -- diff

# Git shortcuts
abbr -a ga git add
abbr -a gc git commit -S -v
abbr -a gp git push
abbr -a gs git status
abbr -a gd git diff

# Avoid accidentally deleting files
abbr -a mv mv -i
abbr -a rm rm -v

# Copy things to x clipboard
abbr -a xcopy xclip -in -sel clip
abbr -a xcopyprim xclip -in -sel prim

# View stuff with kitty
if test "$TERM" = "xterm-kitty"
  abbr -a icat kitty +kitten icat;
end

# Create todo alias if I've actually got a file for it
if test -f ~/.todo
  abbr todo cat ~/.todo
end
