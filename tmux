# prefix
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# mouse
set -g mouse on

# set window split
bind-key v split-window -h
bind-key b split-window

# Activity monitoring
setw -g monitor-activity on
set -g visual-activity on

# hjkl pane traversal
bind -n M-h select-pane -L
bind -n M-j select-pane -D
bind -n M-k select-pane -U
bind -n M-l select-pane -R

# new window
bind-key C command-prompt -p "Name of new window: " "new-window -n '%%'"

# reload config
bind r source-file ~/.tmux.conf \; display-message "Config reloaded..."

# auto window rename
set-window-option -g automatic-rename

# window indexes
set -g base-index 1

# No delay for escape key press
set -sg escape-time 0

# color
set -g default-terminal "screen-256color"

# THEME
set-option -g status-position top
set -g status-bg black
set -g status-fg white
set -g window-status-current-bg white
set -g window-status-current-fg black
set -g window-status-current-attr bold
set -g status-interval 60
set -g status-left-length 30
set -g status-left ''
set -g status-right '#[fg=green]#(whoami) #[fg=yellow]#S #[fg=white]#[bold]%H:%M'
setw -g window-status-current-format "#I:#W"
setw -g window-status-format "#I:#W"

# statusline theme
# source "$HOME/.tmux/statusline"

# Vi copy/paste mode
set-window-option -g mode-keys vi
