
function fish_right_prompt
    set -g __fish_git_prompt_showdirtystate 1
    set -g __fish_git_prompt_showuntrackedfiles 1
    set -g __fish_git_prompt_showupstream informative
    set -g __fish_git_prompt_showcolorhints 1
    set -g __fish_git_prompt_use_informative_chars 1

    string match -qi "*.utf-8" -- $LANG $LC_CTYPE $LC_ALL
    and set -g __fish_git_prompt_char_dirtystate \U1F4A9
    set -g __fish_git_prompt_char_untrackedfiles "?"

    set -l vcs (fish_vcs_prompt '(%s)' 2>/dev/null)
    set -l time (set_color brgrey)(date "+%R")(set_color normal)

    # Duration
    set -l duration ""
    if set -q cmd_duration
        and test "$cmd_duration" -gt 100
        set duration (math $cmd_duration / 1000)s
    end

    # Virtual env name
    set -q VIRTUAL_ENV_DISABLE_PROMPT; or set -g VIRTUAL_ENV_DISABLE_PROMPT true
    set -l venv ""
    set -q VIRTUAL_ENV; and set venv (string replace -r '.*/' '' -- "$VIRTUAL_ENV")

    # Join parts with consistent spacing
    set -l parts
    test -n "$venv"; and set parts $parts $venv
    test -n "$duration"; and set parts $parts $duration
    test -n "$vcs"; and set parts $parts $vcs
    set parts $parts $time

    set_color normal
    string join ' ' $parts
end
