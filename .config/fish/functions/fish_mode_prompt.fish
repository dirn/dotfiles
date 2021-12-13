function fish_mode_prompt --description 'Displays the current mode'
    # Do nothing if not in vi mode
    if test "$fish_key_bindings" = fish_vi_key_bindings
        or test "$fish_key_bindings" = fish_hybrid_key_bindings
        switch $fish_bind_mode
            case default
                set_color --bold $fish_color_mode_default
                echo '[N]'
            case insert
                set_color --bold $fish_color_mode_insert
                echo '[I]'
            case replace_one
                set_color --bold $fish_color_mode_replace_one
                echo '[R]'
            case replace
                set_color --bold $fish_color_mode_replace
                echo '[R]'
            case visual
                set_color --bold $fish_color_mode_visual
                echo '[V]'
        end
        set_color normal
        echo -n ' '
    end
end
