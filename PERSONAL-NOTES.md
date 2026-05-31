Paths to symlinks for my programms&packages: 
per user: /etc/profiles/per-user/$USERNAME/ *here*
system: /run/current-system/sw/ *here*

usually its /bin/ next to get programs, but /lib/ sometimes may also do


to check for flake outputs, the command 
`nix flake show flake-url` can be used.


always run `sudo chown -R $USER:$USER .` if you wish to add new files to this directory on a new machine