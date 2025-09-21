function fish_prompt

    # Prompt status only if it's not 0
    set -l stat
    if test $status -ne 0
        set stat (set_color red)"[$status]"(set_color normal)
    end

    # Configure version control prompt info
    set -g __fish_git_prompt_showupstream "auto"
    set -g __fish_git_prompt_showdirtystate true
    set -g __fish_git_prompt_use_informative_chars true

    set -g __fish_git_prompt_char_upstream_ahead "↑"
    set -g __fish_git_prompt_char_upstream_behind "↓"
    # set -g __fish_git_prompt_char_upstream_diverged "↓↑"
    set -g __fish_git_prompt_char_dirtystate "*"
    set -g __fish_git_prompt_char_stagedstate "+"
    set -g __fish_git_prompt_char_invalidstate "#"

    # Input prompt
    set -l my_input_prompt ':// '(set_color normal)

    # Build prompt
    # TODO: color
    string join '' -- (prompt_login) ' ' (prompt_pwd --full-length-dirs 2) (fish_vcs_prompt) ' ' $stat \n $my_input_prompt

end
