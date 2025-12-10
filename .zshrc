# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

export KEYTIMEOUT=0.1
source ~/fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ----- Bat (better cat) -----
export BAT_THEME=tokyonight_night
eval "$(zoxide init zsh)"
export EDITOR="nvim"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

#aliases
alias ls="eza --icons=always"
alias cd="z"
alias python="python3"

#touch pad disabling (search sys id by typing "ls /sys/bus/i2c/devices/")
alias touchpad-off='echo "i2c-ASUP1301:00" | echo "i2c-ASUP1301:00" | sudo tee /sys/bus/i2c/drivers/i2c_hid_acpi/unbind && notify-send "🌙 Touchpad Disabled" "Your gestures are now at rest."'
alias touchpad-on='echo "i2c-ASUP1301:00" | echo "i2c-ASUP1301:00" | sudo tee /sys/bus/i2c/drivers/i2c_hid_acpi/bind && notify-send "🌙 Touchpad Disabled" "Your gestures are now at rest."'

#yt-download
# Download best quality video
alias ytbest='yt-dlp -f "bestvideo+bestaudio/best" -o "~/Videos/%(title)s.%(ext)s"'

# Download 1080p mp4 only
alias yt1080='yt-dlp -f "bestvideo[ext=mp4][height<=1080]+bestaudio[ext=m4a]/mp4" -o "~/Videos/%(title)s.%(ext)s"'

# Download audio only (mp3)
alias ytmp3='yt-dlp -x --audio-format mp3 -o "~/Music/%(title)s.%(ext)s"'

# Download playlist into a folder
alias ytplaylist='yt-dlp -o "~/Videos/%(playlist_title)s/%(title)s.%(ext)s"'

# Instagram / generic site downloader (same command works)
alias igdl='yt-dlp -o "~/Videos/Instagram/%(title)s.%(ext)s"'

# Switch branch
alias git-switch='git checkout'
# Create new branch and switch
alias git-cswitch='git checkout -b'
# Merge master into current branch
alias git-merge='git merge master'
# Pull latest master and return to current branch
alias git-pull='git checkout master && git pull origin master && git checkout -'
# Delete a branch locally and remotely
alias git-delete-branch='f() { git branch -d $1 && git push origin --delete $1; }; f'
#for my git
git-create() {
  if [ -z "$1" ]; then
    echo "❗ Please provide a repository name."
    return 1
  fi

  if [ ! -d .git ]; then
    echo "📦 Initializing Git repository..."
    git init
  fi

  gh repo create "$1" --public --source=. --remote=origin
}

alias git-push-init='git add . && git commit -m "Initial commit" && git push -u origin master'

git-update() {
  if [ -z "$1" ]; then
    echo "❗ Please provide a commit message."
    return 1
  fi
  git add .
  git commit -m "$1"
  git push
}

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

