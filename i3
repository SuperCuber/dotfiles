#==> General
# Super (aka Windoze) key
set $mod Mod4
font pango:{{font.monospace}} {{font.size}}
floating_modifier $mod
set $exec exec --no-startup-id
#<==

#==> Shortcuts
# Kill focused window
bindsym $mod+Shift+q kill

# Rofimenu
bindsym $mod+d $exec "rofi -show run"

# Screenshot
{{#if owo_key~}}
bindsym Print $exec "owo --screenshot --clipboard --associated-uploads --key {{owo_key}}"
{{~else~}}
bindsym Print $exec "i3-nagbar -m 'No owo key configured'"
{{~/if}}

# Terminal
bindsym $mod+Return $exec "{{ terminal }}"

# Pulse Audio controls
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume 1 +5% #increase sound volume
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume 1 -5% #decrease sound volume
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute 1 toggle # mute sound

# Media player controls
bindsym XF86AudioPlay exec playerctl play
bindsym XF86AudioPause exec playerctl pause
bindsym XF86AudioNext exec playerctl next
bindsym XF86AudioPrev exec playerctl previous
#<==

#==> Scratchpad
# Make the currently focused window a scratchpad
bindsym $mod+Shift+minus move scratchpad

# Show the first scratchpad window
bindsym $mod+minus scratchpad show
#<==

#==> Focus
# change focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# move focused window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# Vertical and horizontal are stupid, wtf
# split in horizontal orientation
bindsym $mod+b split v

# split in vertical orientation
bindsym $mod+v split h

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen
#<==

#==> Layout
# change container layout (stacked, tabbed, toggle split)
bindsym $mod+e layout toggle split
bindsym $mod+w layout stacked

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# move workspace to next screen
bindsym $mod+p move workspace to output left
#<==

#==> Workspaces
set $work0 "0"
set $work1 "1"
set $work2 "2"
set $work3 "3"
set $work4 "4"
set $work5 "5"
set $work6 "6"
set $work7 "7"
set $work8 "8"
set $work9 "9"

# switch to workspace
bindsym $mod+0 workspace $work0
bindsym $mod+1 workspace $work1
bindsym $mod+2 workspace $work2
bindsym $mod+3 workspace $work3
bindsym $mod+4 workspace $work4
bindsym $mod+5 workspace $work5
bindsym $mod+6 workspace $work6
bindsym $mod+7 workspace $work7
bindsym $mod+8 workspace $work8
bindsym $mod+9 workspace $work9

# move focused container to workspace
bindsym $mod+Shift+0 move container to workspace $work0; workspace $work0
bindsym $mod+Shift+1 move container to workspace $work1; workspace $work1
bindsym $mod+Shift+2 move container to workspace $work2; workspace $work2
bindsym $mod+Shift+3 move container to workspace $work3; workspace $work3
bindsym $mod+Shift+4 move container to workspace $work4; workspace $work4
bindsym $mod+Shift+5 move container to workspace $work5; workspace $work5
bindsym $mod+Shift+6 move container to workspace $work6; workspace $work6
bindsym $mod+Shift+7 move container to workspace $work7; workspace $work7
bindsym $mod+Shift+8 move container to workspace $work8; workspace $work8
bindsym $mod+Shift+9 move container to workspace $work9; workspace $work9

# initial workspace configuration
{{#if primary_screen~}}
workspace $work1 output {{ primary_screen }}
workspace "-1" output {{ primary_screen }}
{{~else~}}
workspace $work1
{{~/if}}
{{#if secondary_screen~}}
workspace "-2" output {{ secondary_screen }}
{{~/if}}

# oh no someone's looking at my screen
{{#if (and primary_screen secondary_screen)~}}
bindsym $mod+q workspace "-1"; workspace "-2"
{{~else~}}
bindsym $mod+q workspace "-1"
{{~/if}}
#<==

#==> Assigns
assign [class="Firefox"] $work2

assign [class="discord"] $work3
assign [class="Thunderbird"] $work3

assign [class="Minecraft"] $work4
assign [class="minecraft-launcher"] $work4
assign [title="Eclipse"] $work4
#<==

#==> Reload
# Restart
bindsym $mod+Shift+r restart
bindsym $mod+Shift+e reload
#<==

#==> Resize
# resize window (you can also use the mouse for that)
mode "resize" {
    # Pressing left will shrink the window's width.
    # Pressing right will grow the window's width.
    # Pressing up will shrink the window's height.
    # Pressing down will grow the window's height.
    bindsym h resize shrink width 10 px or 10 ppt
    bindsym j resize grow height 10 px or 10 ppt
    bindsym k resize shrink height 10 px or 10 ppt
    bindsym l resize grow width 10 px or 10 ppt

    # back to normal: Enter or Escape
    bindsym Return mode "default"
    bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"
#<==

#==> Colors
set $focused "#{{colors.background_bright}}"
set $unfocused "#{{colors.background}}"
set $focused_inactive "#{{colors.background}}"
set $urgent "#{{colors.accent}}"
set $text "#{{colors.text}}"

# class                 border            background        text  indicator
client.focused          $focused          $focused          $text $focused
client.unfocused        $unfocused        $unfocused        $text $unfocused
client.focused_inactive $focused_inactive $focused_inactive $text $focused_inactive
client.urgent           $urgent           $urgent           $text $urgent
client.background       #000000
#<==

#==> Gaps
for_window [class="^.*"] border pixel 2
#gaps inner 10
#smart_gaps yes
#smart_borders yes

set $mode_gaps Gaps: (o)uter, (i)nner
set $mode_gaps_outer Outer Gaps: +|-|0
set $mode_gaps_inner Inner Gaps: +|-|0
bindsym $mod+Shift+g mode "$mode_gaps"

mode "$mode_gaps" {
    bindsym o      mode "$mode_gaps_outer"
    bindsym i      mode "$mode_gaps_inner"
    bindsym Return mode "default"
    bindsym Escape mode "default"
}

mode "$mode_gaps_inner" {
    bindsym plus  gaps inner all plus 5
    bindsym minus gaps inner all minus 5
    bindsym 0     gaps inner all set 0

    bindsym Return mode "default"
    bindsym Escape mode "default"
}

mode "$mode_gaps_outer" {
    bindsym plus  gaps outer all plus 5
    bindsym minus gaps outer all minus 5
    bindsym 0     gaps outer all set 0

    bindsym Return mode "default"
    bindsym Escape mode "default"
}

#<==

$exec ~/.scripts/startup

# vim:foldmethod=marker:foldmarker=\=\=>,<\=\=:
