# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# If set to an empty array, this variable will have no effect.

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias load-yabai='launchctl load ~/Library/LaunchAgents/org.yabai.yabai.plist'
alias unload-yabai='launchctl unload ~/Library/LaunchAgents/org.yabai.yabai.plist'
alias load-skhd='launchctl load ~/Library/LaunchAgents/org.skhd.skhd.plist'
alias unload-skhd='launchctl unload ~/Library/LaunchAgents/org.skhd.skhd.plist'
alias clear='clear && ~/.config/zsh/startup.sh'
alias avenv='source .venv/bin/activate'
alias cvenv='python3 -m venv .venv'
alias nrd='npm run dev'
alias vim="nvim"
alias gcf='SKIP_CONVENTIONAL_COMMIT=1 git commit'
alias opengit="open $(git config --get remote.origin.url | sed -e 's/:/\//' -e 's/git@/https:\/\//' -e 's/\.git$//')"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

[ -x ~/.config/zsh/startup.sh ] && ~/.config/zsh/startup.sh

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
export PATH="/opt/homebrew/bin/gcloud:$PATH"
export PATH="$PATH:$HOME/.dotnet/tools"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# automate dev setup
dev() {
    # 1. Define the project path and server type
    local PROJ_PATH="."
    local SERVER_CMD=""

    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --expo) SERVER_CMD="npx expo start --ios" ;;
            --react) SERVER_CMD="npm run dev" ;;
            *) PROJ_PATH="$1" ;;
        esac
        shift
    done

    # 2. Convert to absolute path
    local ABS_PATH=$(cd "$PROJ_PATH" && pwd)

    # 3. Use AppleScript to tell iTerm2 what to do
    osascript <<EOF
      tell application "iTerm"
          activate
          
          -- 1. Use the tab you are currently sitting in
          tell current session of current window
              write text "cd $ABS_PATH && vim ."
          end tell
          
          -- 2. Create the second tab
          tell current window
              create tab with default profile
              tell current session
                  write text "cd $ABS_PATH && claude"
              end tell
          end tell
          
          -- 3. Create the third tab
          tell current window
              create tab with default profile
              tell current session
                    write text "cd $ABS_PATH"
                    if "$SERVER_CMD" is not "" then
                        write text "$SERVER_CMD"
                    else
                        write text "clear"
                    end if
              end tell
              
              -- 4. Switch focus back to the first tab (vim)
              select tab 1
          end tell
          
      end tell
EOF
}

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
source ~/.config/zsh/rcb.zsh

# Machine-specific settings and secrets (API keys, private aliases) – not in git
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
