# Dot File Management
I have always wanted a simple way of managing my bash file settings (`.bashrc`, `.bash_profile` and the like). I had built a system much like this one, but it didn't work very well. So this is a ground-up rewrite

This repo contains a slightly modified copy of what you would find in the default `/etc/skel` on a Fedora 11 system. But you actually only need the makefile

Of my modifications you'll find the useful stuff in `_bashrc` and `_profile.d`.

## Instructions
### Creating source files
Any file which matches the shell glob `_*` will be linked into `$HOME` as a symlink with the first `_`  replaced with a `.`

For example:

    _bashrc

becomes

    ${HOME}/.bashrc

### Installing source files
It's as simple as running:

    make

From this top-level directory.

## Requirements
* bash
* gnu make
