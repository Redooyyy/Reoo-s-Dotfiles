# My Dotfiles

Welcome to my personal dotfiles repository! This collection manages the configuration for my essential tools, ensuring a consistent and productive development environment across different machines.

These configurations are tailored for a modern Linux/Unix setup, primarily using **Hyprland** (or Sway) on **Arch Linux** (or similar distribution).

## Key Components

| Component    | Description                                                                                                                                                                                                                           | Location           |
| :----------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :----------------- |
| **`nvim`**   | Highly customized Neovim configuration focused on speed, LSP integration (Language Server Protocol), and key mappings for efficient code editing. It focused on flutter development, competitive programming also in web development. | `./config/nvim/`   |
| **`tmux`**   | Terminal multiplexer setup for persistent sessions, split panes, and integrated status bar.                                                                                                                                           | `./.tmux.conf`     |
| **`zsh`**    | Configuration for the Z Shell, including aliases, functions, prompt theming, and plugins (managed by **Zinit** or similar).                                                                                                           | `./.zshrc`         |
| **`waybar`** | Status bar configuration for my Wayland Compositor (e.g., Hyprland/Sway), providing essential system and workspace information.                                                                                                       | `./config/waybar/` |
| **`kitty`**  | Configuration for the fast, GPU-accelerated terminal emulator, defining colors, fonts, and keybindings.                                                                                                                               | `./config/kitty/`  |
| **`yazi`**   | Blazing fast terminal file manager written in Rust, configured with custom theme, keybindings, and plugins.                                                                                                                           | `./config/yazi/`   |

## Installation

### Prerequisites

Before starting, ensure you have the following core utilities installed on your system:

- **Git**
- **Zsh**
- **Neovim** (v0.9+)
- **Tmux**
- **Waybar** (and a Wayland compositor like Hyprland/Sway)
- **Kitty**
- **Yazi** (and its dependencies like `ffmpegthumbnailer`, `unzip`, etc.)
- **Nerd Fonts** (Essential for proper icon rendering)

### 1. Install Stow

Install stow in your system

Arch based system

```bash
sudo pacman -S stow
```

Ubuntu/Debian

```bash
sudo apt install stow
```

### 2. Clone the Repository

Clone this repository to your home directory:

```bash
git clone https://github.com/Redooyyy/Reoo-s-DotfilesDotfiles.git
```

### 3. Navigate to the cloned repository

```bash
cd Reoo-s-DotfilesDotfiles
```

### 4. Stow all dotfiles

```bash
stow .
```
