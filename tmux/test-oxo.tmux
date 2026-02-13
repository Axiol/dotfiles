#!/usr/bin/env sh

# Oxocarbon color palette
oxo_bg="#161616"
oxo_fg="#f2f4f8"
oxo_base00="#262626"
oxo_base01="#393939"
oxo_base02="#525252"
oxo_base03="#dde1e6"
oxo_pink="#ff7eb6"
oxo_purple="#be95ff"
oxo_blue="#78a9ff"
oxo_cyan="#3ddbd9"
oxo_green="#42be65"
oxo_yellow="#ffe97b"
oxo_orange="#ff832b"
oxo_red="#ee5396"

# Tmux options
set -g status-style "bg=${oxo_base00},fg=${oxo_fg}"
set -g status-left-length 50
set -g status-right-length 0
set -g status-right ""

# Pane borders
set -g pane-border-style "fg=${oxo_base01}"
set -g pane-active-border-style "fg=${oxo_blue}"

# Window status
set -g window-status-style "fg=${oxo_base02}"
set -g window-status-current-style "fg=${oxo_blue},bold"
set -g window-status-format " #I:#W "
set -g window-status-current-format " #I:#W "
set -g window-status-separator ""

# Status left - Session name and mode indicator
set -g status-left "#[fg=${oxo_base03},bg=${oxo_base00},bold] #S #[fg=${oxo_blue},bg=${oxo_bg}]#{?client_prefix,#[fg=${oxo_bg}]#[bg=${oxo_pink}] PREFIX #[fg=${oxo_pink}]#[bg=${oxo_bg}],#{?pane_in_mode,#[fg=${oxo_bg}]#[bg=${oxo_yellow}]  COPY  #[fg=${oxo_cyan}]#[bg=${oxo_bg}],#[fg=${oxo_bg}]#[bg=${oxo_cyan}] NORMAL #[fg=${oxo_green}]#[bg=${oxo_bg}]}}"

# Message style
set -g message-style "bg=${oxo_base00},fg=${oxo_fg}"
set -g message-command-style "bg=${oxo_base00},fg=${oxo_fg}"

# Mode style (for copy mode)
set -g mode-style "bg=${oxo_base01},fg=${oxo_cyan}"

# Clock mode
set -g clock-mode-colour "${oxo_blue}"
