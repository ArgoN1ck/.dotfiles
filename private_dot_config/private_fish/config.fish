if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting ""

# Config path
set -x XDG_CONFIG_HOME $HOME/.config

# Homebrew environment
/opt/homebrew/bin/brew shellenv | source

# Goenv
set -x GOENV_ROOT $HOME/.goenv
set -x PATH $GOENV_ROOT/bin $PATH
status --is-interactive; and source (goenv init - fish | psub)

# Starship
starship init fish | source

# Aliases
alias ls "eza --icons=always --level=1 --tree"
alias nvconf "nvim --cmd 'cd ~/.config/nvim' ~/.config/nvim/init.lua"
alias nvfish "nvim --cmd 'cd ~/.config/fish' ~/.config/fish/config.fish"
alias nvtmux "nvim --cmd 'cd ~/.config/tmux' ~/.config/tmux/tmux.conf"
alias nv "nvim"
alias lg "lazygit"
# bare-repo dotfiles removed — will use chezmoi later
# alias dot='git --git-dir=$HOME/Coding/Sync/dotfiles --work-tree=$HOME/.config'

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

# if command -q tmux
#     if not string match -q -r "screen(-256color)?" -- $TERM
#         tmux attach -t default; or tmux new -s default
#         exit
#     end
# end
fish_add_path $HOME/.local/bin
