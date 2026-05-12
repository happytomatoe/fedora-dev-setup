# Fedora Dev Setup

Automated setup for Fedora development environment.

## Quick Start

### Prerequisites
```bash
sudo dnf install -y just
```

### Run Setup
```bash
just install
just copy-config
```

## What's Installed

| Category | Tools |
|----------|-------|
| Terminal | Ghostty, Fish shell with plugins (fzf, zoxide, yazi, git, and more) |
| CLI Tools | fzf, zoxide, yazi, uv (Python), Rust, tldr |
| Multiplexer | Zellij |
| Editors | Neovim (LazyVim), VS Code |
| Container | Docker Engine |
| Browser | Brave (+ Vimium extension) |
| Dev Tools | gcc, make, and other development tools |

## Post-Install

After running `just copy-config`, Fish shell will have:
- Custom prompt with git status
- Abbreviation tips
- FZF integration
- Zoxide integration
- Colored man pages
- And more
