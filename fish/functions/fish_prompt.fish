function fish_prompt
    set -l last_status $status

    set -l normal (set_color normal)
    set -l usercolor (set_color $fish_color_user)

    # Choose delimiter
    set -l delim "> "
    string match -qi "*.utf-8" -- $LANG $LC_CTYPE $LC_ALL; or set delim "> "
    fish_is_root_user; and set delim "# "

    # Compute working directory color (disco logic)
    set -l cwd_color (set_color $fish_color_cwd)
    if command -sq cksum
        set -l shas (pwd -P | cksum | string split -f1 ' ' | math --base=hex | string sub -s 3 | string pad -c 0 -w 6 | string match -ra ..)
        set -l col 0x$shas[1..3]

        while test (math 0.2126 x $col[1] + 0.7152 x $col[2] + 0.0722 x $col[3]) -lt 120
            set col[1] (math --base=hex "min(255, $col[1] + 60)")
            set col[2] (math --base=hex "min(255, $col[2] + 60)")
            set col[3] (math --base=hex "min(255, $col[3] + 60)")
        end
        set -l col (string replace 0x '' $col | string pad -c 0 -w 2 | string join "")
        set cwd_color (set_color $col)
    end

    # Status if nonzero
    set -l prompt_status
    if test $last_status -ne 0
        set prompt_status (set_color $fish_color_status)"[$last_status]"$normal
    end

    # Only show host if in SSH or container
    if not set -q prompt_host
        set -g prompt_host ""
        if set -q SSH_TTY
            or begin
                command -sq systemd-detect-virt
                and systemd-detect-virt -q
            end
            set prompt_host $usercolor$USER$normal@(set_color $fish_color_host)$hostname$normal
        end
    end

    # Build the prompt line cleanly (avoid extra/missing spaces)
    set -l parts
    test -n "$prompt_host"; and set parts $parts $prompt_host
    set parts $parts $cwd_color(prompt_pwd)$normal
    test -n "$prompt_status"; and set parts $parts $prompt_status

    echo -n (string join ' ' $parts) " $delim"
end
