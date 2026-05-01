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
| Terminal | Ghostty, Fish shell with plugins (fzf, zoxide, etc.) |
| Multiplexer | Zellij |
| Editors | Neovim (LazyVim), VS Code, IntelliJ IDEA CE, PyCharm CE |
| Container | Docker CLI |
| Browser | Brave |
| Dev Tools | gcc, make, etc. |
