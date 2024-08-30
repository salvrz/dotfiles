# For Pure theme instructions: https://github.com/sindresorhus/pure#install

# PURE PROMPT SETUP {{{

	fpath+=$HOME/.zsh/pure
	autoload -Uz promptinit
	promptinit
	prompt pure

	# Styling
	zstyle ':prompt:pure:path' color '#B16286' # purple
	zstyle ':prompt:pure:git:*' color '#FE8019' # light orange
	zstyle ':prompt:pure:git:branch' color '#EBDBB2' # cream
	zstyle ':prompt:pure:prompt' color '#83A598' # light blue
	zstyle ':prompt:pure:prompt:continuation' color '#EBDBB2' # cream
	zstyle ':prompt:pure:execution_time' color '#83A598' # light blue
	zstyle ':prompt:pure:user' color '#458588' # blue
	zstyle ':prompt:pure:host' color '#458588' # blue

	PURE_PROMPT_SYMBOL="%B://%b"

# }}}


# KEYBINDINGS {{{

	bindkey -e  # Use emacs keybindings even if our EDITOR is set to vi
	bindkey "^[h" backward-word
	bindkey "^]l" forward-word
	bindkey "^h" backward-char
	bindkey "^l" forward-char

# }}}


# HISTORY {{{

	# Share history between terminals
	setopt histignorealldups sharehistory

	# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
	HISTSIZE=1000
	SAVEHIST=1000
	HISTFILE=~/.zsh_history

# }}}


# TAB COMPELTE {{{

	# Use modern completion system
	autoload -Uz compinit
	compinit

	zstyle ':completion:*' auto-description 'specify: %d'
	zstyle ':completion:*' completer _expand _complete _correct _approximate
	zstyle ':completion:*' format 'Completing %d'
	zstyle ':completion:*' group-name ''
	zstyle ':completion:*' menu select=2
	eval "$(dircolors -b)"
	zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
	zstyle ':completion:*' list-colors ''
	zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
	zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
	zstyle ':completion:*' menu select=long
	zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
	zstyle ':completion:*' use-compctl false
	zstyle ':completion:*' verbose true
	
	zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
	zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# }}}


# PEARL CONFIG FOR GIT GMAIL ACCESS {{{

	PATH="/home/salvar/perl5/bin${PATH:+:${PATH}}"; export PATH;
	PERL5LIB="/home/salvar/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
	PERL_LOCAL_LIB_ROOT="/home/salvar/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
	PERL_MB_OPT="--install_base \"/home/salvar/perl5\""; export PERL_MB_OPT;
	PERL_MM_OPT="INSTALL_BASE=/home/salvar/perl5"; export PERL_MM_OPT;

# }}}


# DEFAULT EDITOR {{{

	export VISUAL=nvim
	export EDITOR="$VISUAL"
	export GIT_EDITOR=nvim
	export GPG_TTY=$(tty)

# }}}


# ALIASES {{{

	alias ls="ls --color=auto"
	alias ll="ls -alF"
	alias l="ls -CF"
	alias mutttoken="sh ~/.mutt/oauth/refresh_token.sh"
	alias nmutt="neomutt"
	alias btmg="btm --color=gruvbox"

# }}}


# THIRD PARTY EDITS {{{

	# PYTHON {{{

		export PATH="$HOME/.poetry/bin:$PATH"
		export PATH="$PATH:/home/salvar/.local/bin"  # For pipx

	# }}}


	# DIRENV {{{

		eval "$(direnv hook zsh)"

	# }}}


	# RANGER {{{

		# Force ranger to use ~/.config/ranger/rc.conf
		export RANGER_LOAD_DEFAULT_RC=false

	# }}}


	# GCC ARM {{{

		export GCC_ARM_TOOLS_PATH=/opt/arm-gnu-toolchain-12.2/bin

	# }}}

# }}}
