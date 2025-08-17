# Dotfiles

This repository contains my personal Zsh configuration files and scripts to quickly set up a new machine.

## Contents

- `.zshrc` - Main Zsh configuration file.
- `.zsh_aliases` - Aliases for commonly used commands.
- `.zsh_functions` - Custom Zsh functions.
- `setup.sh` - Script to initialize the dotfiles on a new machine.

## Usage

1. Clone this repository:
```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```
2. Run the setup script:
```bash
./setup.sh
```

## Conclusion

This will -

- Backup any existing .zshrc .zsh_aliases and .zsh_functions
- Create symlinks to the files in this repos
- Source the new .zshrc immediately.