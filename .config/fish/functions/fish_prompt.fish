# name: sashimi
# function fish_prompt
#   set -l last_status $status
#   set -l cyan (set_color -o cyan)
#   set -l yellow (set_color -o yellow)
#   set -g red (set_color -o red)
#   set -g blue (set_color -o blue)
#   set -l green (set_color -o green)
#   set -g normal (set_color normal)

#   set -l ahead (_git_ahead)
#   set -g whitespace ' '

#   if test $last_status = 0
#     set initial_indicator "$green◆"
#     set status_indicator "$normal❯$cyan❯$green❯"
#   else
#     set initial_indicator "$red✖ $last_status"
#     set status_indicator "$red❯$red❯$red❯"
#   end
#   set -l cwd $cyan(basename (prompt_pwd))

#   if [ (_git_branch_name) ]

#     if test (_git_branch_name) = 'master'
#       set -l git_branch (_git_branch_name)
#       set git_info "$normal git:($red$git_branch$normal)"
#     else
#       set -l git_branch (_git_branch_name)
#       set git_info "$normal git:($blue$git_branch$normal)"
#     end

#     if [ (_is_git_dirty) ]
#       set -l dirty "$yellow ✗"
#       set git_info "$git_info$dirty"
#     end
#   end

#   # Notify if a command took more than 5 minutes
#   if [ "$CMD_DURATION" -gt 300000 ]
#     echo The last command took (math "$CMD_DURATION/1000") seconds.
#   end

#   echo -n -s $initial_indicator $whitespace $cwd $git_info $whitespace $ahead $status_indicator $whitespace
# end

# function _git_ahead
#   set -l commits (command git rev-list --left-right '@{upstream}...HEAD' 2>/dev/null)
#   if [ $status != 0 ]
#     return
#   end
#   set -l behind (count (for arg in $commits; echo $arg; end | grep '^<'))
#   set -l ahead  (count (for arg in $commits; echo $arg; end | grep -v '^<'))
#   switch "$ahead $behind"
#     case ''     # no upstream
#     case '0 0'  # equal to upstream
#       return
#     case '* 0'  # ahead of upstream
#       echo "$blue↑$normal_c$ahead$whitespace"
#     case '0 *'  # behind upstream
#       echo "$red↓$normal_c$behind$whitespace"
#     case '*'    # diverged from upstream
#       echo "$blue↑$normal$ahead $red↓$normal_c$behind$whitespace"
#   end
# end

# function _git_branch_name
#   echo (command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
# end

# function _is_git_dirty
#   echo (command git status -s --ignore-submodules=dirty 2>/dev/null)
# end

function fish_prompt --description Hydro
    echo -e "$_hydro_color_pwd$_hydro_pwd$hydro_color_normal $_hydro_color_git$$_hydro_git$hydro_color_normal$_hydro_color_duration$_hydro_cmd_duration$hydro_color_normal$_hydro_status$hydro_color_normal "
end

# function __transient_prompt_func
#     set --local color green
#     if test $transient_pipestatus[-1] -ne 0
#         set color red
#     end
#     echo -en (set_color $color)"❯ "(set_color normal)
# end

# function __fish_prompt --description "make fish prompt transient"
#     if not type -q fish_prompt
#         or test -n "$(functions -v fish_prompt | string match --regex '^\s+# @__TRANSIENT__@')"
#         return 0
#     end

#     # fix enable virtualenv
#     if type --query _old_fish_prompt
#         functions --erase _old_fish_prompt && functions --copy __transient_old_fish_prompt _old_fish_prompt
#     end
#     functions --erase __transient_old_fish_prompt 2>/dev/null && functions --copy fish_prompt __transient_old_fish_prompt

#     # replace $[pipe]status to $transient_[pipe]status
#     functions -v __transient_old_fish_prompt | string replace -r '\$status([\s+])' '\$transient_status$1' | string replace -r '\$pipestatus([\s+])' '\$transient_pipestatus$1' | source

#     function fish_prompt
#         # It's a flag, it's important
#         # @__TRANSIENT__@
#         set --global transient_pipestatus $pipestatus
#         set --global transient_status $status

#         if test "$TRANSIENT" = normal
#             __transient_old_fish_prompt
#             return 0
#         end

#         echo -en \e\[0J # clear from cursor to end of screen
#         if type --query transient_prompt_func
#             transient_prompt_func
#         else
#             __transient_prompt_func
#         end

#         set --global TRANSIENT normal
#         set --global TRANSIENT_RIGHT transient
#         commandline --function repaint
#     end
# end
