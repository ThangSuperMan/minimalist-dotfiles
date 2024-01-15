set fish_greeting ""

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias ll "exa -l -g --icons"
alias lla "ll -a"
alias g git
alias thanos "kill -9"
alias p "cd Projects/"
alias n "cd notes/"
alias v "nvim"
alias tks "tmux kill-server"
alias pn "pnpm"
alias grm "go run main.go"
alias cpp "g++ -std=c++17 -o main main.cpp"
alias c "clear"
alias tn "tmux new -s (pwd | sed 's/.*\///g')"
alias ta "tmux attach"
alias myip "curl ifconfig.me"
alias nc "nc -z -vv"
alias ide "tmux split-window -v -p 30 && tmux split-window -h -p 64 && tmux split-window -h -p 50"
alias nv "cd $HOME/.config/nvim"
alias espanso "cd $HOME/Library/Application Support/espanso/match"
alias kms "cd ~/Developments/KMS"
alias dev "cd $HOME/Developments/"
alias downloads "cd $HOME/Downloads"
alias ip "ifconfig en0 | grep inet"
abbr --add \? duck
alias e "exit"
alias http "xh"
alias tf="terraform"

# Docker
alias bd "bun dev"
alias bi "bun install"

alias sed "gsed"

# Jqp
# alias jqp "jqp -t nord"

# Docker
alias dco "docker-compose"
alias dps "docker ps"
alias dpa "docker ps -a"
alias di "docker images"

# Docker compose
alias dcps "docker-compose ps"

# alias dco="podman-compose"
# alias dps "podman ps"
# alias dpa "podman ps -a"
# alias di "podman images"
# alias docker "podman"

# Yarn
alias y "yarn"
alias ys "yarn start"
alias yt "yarn test"

# Kubernetes
alias kb 'kubectl'
alias kbc 'kubecolor'
alias kbaf 'kbc apply -f'
alias kbcf 'kbc create -f'
alias kbd='kb describe'
alias kbga 'kbc get all'
alias kbgd 'kbc get deployments'
alias kbgn 'kbc get nodes'
alias kbgs 'kbc get services'
alias kbgp 'kbc get pods'

# Rails
alias r 'rails'
alias rs 'rails server'
alias rc 'rails console'
alias rr 'rails routes'
alias rdb 'rails db:seed'

# Execute application
alias elasticsearch5 '/Applications/elasticsearch-5.4.0/bin/elasticsearch'
alias elasticsearch6 '/Applications/elasticsearch-6.0.0/bin/elasticsearch'
# alias kibana '/Applications/kibana-5.4.0-darwin-x86_64/bin/kibana'

set -Ux FZF_DEFAULT_OPTS "\
--reverse \
--border rounded \
--no-info \
--pointer=' ' \
--marker=' ' \
--ansi \
--color='16,bg+:-1,gutter:-1,prompt:5,pointer:5,marker:6,border:4,label:4,header:italic'"

set -Ux FZF_TMUX_OPTS "-p 55%,60%"

set -Ux FZF_CTRL_R_OPTS "--border-label=' history ' \
--prompt='  '"

export ARCHFLAGS="-arch x86_64"

# Enable vim mode
#fish_vi_key_bindings

# Mysql
# fish_add_path /usr/local/mysql-8.0.32-macos13-arm64/bin

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
# set -g GOPATH $HOME/go
# set -gx PATH $GOPATH/bin $PATH

# Rust
set -gx PATH $HOME/.cargo/bin $PATH

# Java
set -xg JAVA /usr/bin/java

# Flutter and dart
# set -gx PATH $HOME/opt/homebrew/bin/flutter

# Mysql
# set -x PATH ${PATH}:/usr/local/mysql-8.0.31-macos12-arm64/bin
# set -x PATH usr/local/mysql-8.0.31-macos12-arm64/bin $PATH

switch (uname)
  case Darwin
    source (dirname (status --current-filename))/config-osx.fish
  case Linux
    source (dirname (status --current-filename))/config-linux.fish
  case '*'
    source (dirname (status --current-filename))/config-windows.fish
end

eval $(/usr/local/bin/brew shellenv)

# Ruby On Rails
# ENV variables for connect to Postgresql in with Rails
# set -xg APPNAME_DATABASE_PASSWORD "thanghandsome"
# Config postgresql@12 with homebrew
# set -x PATH /opt/homebrew/opt/postgresql@12/bin $PATH
# set -x LDFLAGS "-L/opt/homebrew/opt/postgresql@12/lib"
# set -x CPPFLAGS "-I/opt/homebrew/opt/postgresql@12/include"
# set -x LDFLAGS "-L/opt/homebrew/opt/postgresql@12/lib"
# set -x CPPFLAGS "-I/opt/homebrew/opt/postgresql@12/include"

# If you need to have postgresql@12 first in your PATH, run:
fish_add_path /usr/local/opt/postgresql@12/bin

# fish_add_path /usr/local/opt/postgresql@13/bin

# For compilers to find postgresql@12 you may need to set:
set -gx LDFLAGS "-L/usr/local/opt/postgresql@12/lib"
set -gx CPPFLAGS "-I/usr/local/opt/postgresql@12/include"

# For compilers to find postgresql@13 you may need to set:
# set -gx LDFLAGS "-L/usr/local/opt/postgresql@13/lib"
# set -gx CPPFLAGS "-I/usr/local/opt/postgresql@13/include"

fish_add_path /usr/local/opt/qt@5/bin

# Support install pg when there is error
# fish_add_path /usr/local/opt/libpq/bin

# set -x PATH /usr/local/opt/libpq/bin $PATH

# set -gx LDFLAGS "-L/usr/local/opt/qt@5/lib"
# set -gx CPPFLAGS "-I/usr/local/opt/qt@5/include"

zoxide init fish | source # 'ajeetdsouza/zoxide'
# starship init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
