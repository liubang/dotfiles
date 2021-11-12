# -*- coding: utf-8 -*-

import os
import subprocess
from libqtile import qtile
from libqtile.config import (
    Group,
    Key,
    Match,
    Screen,
    EzClick as Click,
    EzDrag as Drag,
)
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook

mod = "mod1"  # Setting mod key to "SUPER"
term = "/opt/app/bin/kitty"  # Setting terminal to "kitty"

keys = [
    Key([mod], "p", lazy.spawn("/home/liubang/.config/rofi/launchers/colorful/launcher.sh")),
    Key([mod], "w", lazy.spawn("rofi -show window")),
    Key([mod], "Return", lazy.spawn("/opt/app/bin/kitty -e --single-instance")),
    Key([mod, "shift"], "c", lazy.window.kill()),
    Key([mod, "shift"], "q", lazy.spawn("xkill")),
    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod, "control"], "a", lazy.spawn("/usr/bin/flameshot gui")),
    # Window controls
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    # FLIP LAYOUT FOR BSP
    Key([mod, 'mod4'], "k", lazy.layout.flip_up()),
    Key([mod, 'mod4'], "j", lazy.layout.flip_down()),
    Key([mod, 'mod4'], "l", lazy.layout.flip_right()),
    Key([mod, 'mod4'], "h", lazy.layout.flip_left()),
    # MOVE WINDOWS UP OR DOWN BSP LAYOUT
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    # MOVE WINDOWS UP OR DOWN MONADTALL/MONADWIDE LAYOUT
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),
    # TOGGLE FLOATING LAYOUT
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),
    Key([mod], "comma",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete()
        ),
    Key([mod], "period",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([mod], "semicolon",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([mod], "apostrophe",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),
    # QTILE LAYOUT KEYS
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod], "equal", lazy.layout.reset()),
    Key([mod], "m", lazy.layout.maximize()),
    Key([mod, "shift"], "f", lazy.window.toggle_fullscreen()),
]

# ==== Workspaces and Layouts ====
groups = [
    Group("1", label=""),
    Group("2", label=""),
    Group("3", label=""),
    Group("4", label=""),
    Group("5", label=""),
    Group("6", label=""),
    Group("7", label=""),
]

for i in range(len(groups)):
    keys.append(Key([mod], str((i+1)), lazy.group[str(i+1)].toscreen()))
    keys.append(
        Key([mod, "shift"], str((i+1)),
            lazy.window.togroup(str(i+1), switch_group=True))
    )

layout_theme = {
    "border_width": 2,
    "margin": 8,
    "border_focus": "#e8dfD6",
    "border_normal": "#021b21",
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Tile(**layout_theme, ratio=0.5),
    layout.Columns(**layout_theme),
    layout.Matrix(**layout_theme, columns=3),
    layout.MonadWide(**layout_theme),
    layout.RatioTile(**layout_theme),
    layout.TreeTab(**layout_theme),
    layout.Max(**layout_theme),
    layout.Floating(**layout_theme),
]

# ==== Colors ====

# Navy and Ivory - Snazzy based.
colors = [
    ["#021b21", "#021b21"],  # 0
    ["#032c36", "#065f73"],  # 1
    ["#e8dfd6", "#e8dfd6"],  # 2
    ["#c2454e", "#c2454e"],  # 3
    ["#44b5b1", "#44b5b1"],  # 4
    ["#9ed9d8", "#9ed9d8"],  # 5
    ["#f6f6c9", "#f6f6c9"],  # 6
    ["#61778d", "#61778d"],  # 7
    ["#e2c5dc", "#e2c5dc"],  # 8
    ["#5e8d87", "#5e8d87"],  # 9
    ["#032c36", "#032c36"],  # 10
    ["#2e3340", "#2e3340"],  # 11
    ["#065f73", "#065f73"],  # 12
    ["#8a7a63", "#8a7a63"],  # 13
    ["#A4947D", "#A4947D"],  # 14
    ["#BDAD96", "#BDAD96"],  # 15
    ["#a2d9b1", "#a2d9b1"],  # 16
]

# ==== Widgets ====
widget_defaults = dict(
    font="JetBrainsMono Nerd Font Mono Medium",
    fontsize=10,
    padding=3,
)
extension_defaults = widget_defaults.copy()


def top_bar():
    return [
        widget.Sep(
            padding=6,
            linewidth=0,
            background=colors[6],
        ),
        widget.TextBox(
            text=" ",
            font="Hack Nerd Font",
            fontsize=18,
            background=colors[6],
            foreground=colors[0],
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn("rofi -show drun -modi drun")
            },
        ),
        widget.TextBox(
            text="\ue0be",
            font="JetBrainsMono Nerd Font Mono Medium",
            fontsize="33",
            padding=0,
            background=colors[6],
            foreground=colors[0],
        ),
        widget.GroupBox(
            font="Hack Nerd Font",
            fontsize=16,
            margin_y=3,
            margin_x=6,
            padding_y=7,
            padding_x=6,
            borderwidth=4,
            active=colors[8],
            inactive=colors[1],
            rounded=False,
            highlight_color=colors[3],
            highlight_method="block",
            this_current_screen_border=colors[6],
            block_highlight_text_color=colors[0],
        ),
        widget.TextBox(
            text="\ue0be",
            font="JetBrainsMono Nerd Font Mono Medium",
            fontsize=33,
            padding=0,
            background=colors[0],
            foreground=colors[2],
        ),
        widget.WindowName(
            font="Hack Nerd Font",
            fontsize=15,
            max_chars=30,
            background=colors[2],
            foreground=colors[0],
        ),
        widget.TextBox(
            text="\ue0be",
            font="JetBrainsMono Nerd Font Mono Medium",
            fontsize="33",
            padding=0,
            background=colors[2],
            foreground=colors[0],
        ),
        widget.Spacer(
            background=colors[0],
        ),
        widget.TextBox(
            text="\ue0be",
            font="JetBrainsMono Nerd Font Mono Medium",
            fontsize="33",
            padding=0,
            background=colors[0],
            foreground=colors[10],
        ),
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            scale=0.45,
            padding=0,
            background=colors[10],
            foreground=colors[2],
            font="Hack Nerd Font",
            fontsize=15,
        ),
        widget.CurrentLayout(
            font="Hack Nerd Font",
            fontsize=15,
            background=colors[10],
            foreground=colors[2],
        ),
        widget.TextBox(
            text="\ue0be",
            font="JetBrainsMono Nerd Font Mono Medium",
            fontsize="33",
            padding=0,
            background=colors[10],
            foreground=colors[12],
        ),
        widget.TextBox(
            text=" ",
            font="Hack Nerd Font",
            fontsize=15,
            foreground=colors[2],
            background=colors[12],
            padding=0,
            mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("kitty -e bashtop")},
        ),
        widget.Memory(
            background=colors[12],
            foreground=colors[2],
            font="Hack Nerd Font",
            fontsize=15,
            format="{MemUsed: .0f} MB",
            mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("kitty -e bashtop")},
        ),
        widget.Sep(
            padding=8,
            linewidth=0,
            background=colors[12],
        ),
        widget.TextBox(
            text="\ue0be",
            font="JetBrainsMono Nerd Font Mono Medium",
            fontsize="33",
            padding=0,
            background=colors[12],
            foreground=colors[7],
        ),
        widget.Sep(
            padding=6,
            linewidth=0,
            background=colors[7],
        ),
        widget.Systray(
            background=colors[7],
            foreground=colors[2],
            icons_size=18,
            padding=4,
        ),
        widget.TextBox(
            text="\ue0be",
            font="JetBrainsMono Nerd Font Mono Medium",
            fontsize="33",
            padding=0,
            background=colors[7],
            foreground=colors[13],
        ),
        widget.TextBox(
            text="墳",
            font="Hack Nerd Font",
            fontsize=18,
            background=colors[13],
            foreground=colors[0],
        ),
        widget.PulseVolume(
            background=colors[13],
            foreground=colors[0],
            limit_max_volume="True",
            font="Hack Nerd Font",
            fontsize=15,
        ),
        widget.TextBox(
            text="\ue0be",
            font="JetBrainsMono Nerd Font Mono Medium",
            fontsize="33",
            padding=0,
            background=colors[13],
            foreground=colors[15],
        ),
        widget.TextBox(
            text=" ",
            font="Hack Nerd Font",
            fontsize=15,
            padding=0,
            background=colors[15],
            foreground=colors[0],
        ),
        widget.Clock(
            font="Hack Nerd Font",
            foreground=colors[0],
            background=colors[15],
            fontsize=15,
            format="%d %b, %A",
        ),
        widget.Sep(
            padding=6,
            linewidth=0,
            background=colors[15],
        ),
        widget.TextBox(
            text="\ue0be",
            font="JetBrainsMono Nerd Font Mono Medium",
            fontsize="33",
            padding=0,
            background=colors[15],
            foreground=colors[16],
        ),
        widget.TextBox(
            text=" ",
            font="Hack Nerd Font",
            fontsize=18,
            padding=0,
            background=colors[16],
            foreground=colors[0],
        ),
        widget.Clock(
            font="Hack Nerd Font",
            foreground=colors[0],
            background=colors[16],
            fontsize=15,
            format="%I:%M %p",
        ),
        widget.TextBox(
            text="\ue0be",
            font="JetBrainsMono Nerd Font Mono Medium",
            fontsize="33",
            padding=0,
            background=colors[16],
            foreground=colors[6],
        ),
        widget.Sep(
            padding=6,
            linewidth=0,
            background=colors[6],
        ),
    ]


# Spawn bar at multiple screens.
screens = [
    Screen(
        wallpaper="~/Pictures/Wallpapers/z-w-gu-thronef3handfixweb.jpg",
        wallpaper_mode="fill",
        top=bar.Bar(
            top_bar(),
            size=28,
            opacity=0.95,
            background=colors[0],
            margin=[8, 8, 0, 8],
        ),
    ),
]

# ==== Helper functions ====


def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)


def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)


def window_to_previous_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)


def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)


def switch_screens(qtile):
    i = qtile.screens.index(qtile.current_screen)
    group = qtile.screens[i - 1].group
    qtile.current_screen.set_group(group)


# Mod + Mouse drag -> Floating

mouse = [
    Drag("M-1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag("M-3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click("M-2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"

floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(title="Confirmation"),
        Match(title="Qalculate!"),
        Match(wm_class="OBS"),
        Match(wm_class="MultiMC"),
        Match(wm_class="Tilda"),
        Match(wm_class="Steam"),
    ]
)


@hook.subscribe.client_new
def dialogs(window):
    """Floating dialog"""
    if window.window.get_wm_type() == "dialog" or window.window.get_wm_transient_for():
        window.floating = True


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])

