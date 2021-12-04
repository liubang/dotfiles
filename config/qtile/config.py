# -*- coding: utf-8 -*-
import os
import subprocess
from libqtile import qtile
from libqtile.config import (
    Group,
    Key,
    Match,
    Screen,
    Click,
    Drag,
)
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from typing import List  # noqa: F401

# 我的键盘win键和alt调换位置了
mod = "mod1"
HOME = os.path.expanduser("~")
BIN = HOME + "/.config/qtile/bin"

keys = [
    Key([mod], "p", lazy.spawn("rofi -show drun -modi drun")),
    Key([mod], "w", lazy.spawn("rofi -show window")),
    Key([mod], "Return", lazy.spawn("/opt/app/bin/kitty -e --single-instance")),
    Key([mod, "control"], "l", lazy.spawn("/opt/app/bin/lock")),
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
    Group("1", label="", layout="tile", matches=[
        Match(wm_class="google-chrome"),
    ]),
    Group("2", label="", layout="tile", matches=[
        # Match(wm_class="kitty"),
    ]),
    Group("3", label="", layout="tile"),
    Group("4", label="", layout="tile"),
    Group("5", label="", layout="max", matches=[
        Match(wm_class="VirtualBox Manager"),
        Match(wm_class="VirtualBox Machine"),
        Match(wm_class="Vmware"),
    ]),
    Group("6", label="", layout="max", matches=[
        Match(wm_class="spotify"),
        Match(wm_class="ncmpcpp"),
        Match(wm_class="yesplaymusic"),
        Match(wm_class="netease-cloud-music"),
    ]),
]

for i in range(len(groups)):
    keys.append(Key([mod], str((i+1)), lazy.group[str(i+1)].toscreen()))
    keys.append(
        Key([mod, "shift"], str((i+1)),
            lazy.window.togroup(str(i+1), switch_group=True))
    )

# ==== Colors ====

# Navy and Ivory - Snazzy based.
colors = [
    ["#282828", "#282828"],  # 0 background
    ["#ebdbb2", "#ebdbb2"],  # 1 foreground
    ["#fb4934", "#fb4934"],  # 2 red
    ["#cc241d", "#cc241d"],  # 3 red
    ["#98971a", "#98971a"],  # 4 green
    ["#b8bb26", "#b8bb26"],  # 5 green
    ["#d79921", "#d79921"],  # 6 yellow
    ["#fabd2f", "#fabd2f"],  # 7 yellow
    ["#458588", "#458588"],  # 8 blue
    ["#83a598", "#83a598"],  # 9 blue
    ["#b16286", "#b16286"],  # 10 purple
    ["#d3869b", "#d3869b"],  # 11 purple
    ["#689d6a", "#689d6a"],  # 12 aqua
    ["#8ec07c", "#8ec07c"],  # 13 aqua
    ["#a89984", "#a89984"],  # 14 white
    ["#fbf1c7", "#fbf1c7"],  # 15 white
]


layout_theme = {
    "border_width": 2,
    "margin": 8,
    "border_focus": colors[14][0],
    "border_normal": colors[0][0],
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
            padding=10,
            linewidth=0,
        ),
        widget.TextBox(
            text="  ",
            font="Iosevka Nerd Font",
            fontsize=20,
            foreground=colors[15],
            background=colors[13],
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn("rofi -show drun -modi drun")
            },
        ),
        widget.Sep(
            padding=5,
            linewidth=0,
        ),
        widget.TextBox(
            text=' ',
            font="Iosevka Nerd Font",
            fontsize=20,
            foreground=colors[6],
        ),
        widget.CPU(
            font="Hack Nerd Font",
            fontsize=15,
            foreground=colors[1],
            format='{load_percent}%',
        ),
        widget.Sep(
            padding=5,
            linewidth=0,
        ),
        widget.TextBox(
            text=' ',
            font="Iosevka Nerd Font",
            fontsize=17,
            foreground=colors[10],
        ),
        widget.Memory(
            font="Hack Nerd Font",
            fontsize=15,
            foreground=colors[1],
            format='{MemUsed:.0f}{mm}/{MemTotal:.0f}{mm}'
        ),
        widget.Sep(
            padding=5,
            linewidth=0,
        ),
        widget.TextBox(
            text="",
            font="Iosevka Nerd Font",
            foreground=colors[14],
            fontsize=18,
        ),
        widget.Systray(
            foreground=colors[2],
            font="Iosevka Nerd Font",
            icons_size=18,
            padding=4,
        ),
        widget.Spacer(
            length=bar.STRETCH,
        ),
        widget.GroupBox(
            font="Iosevka Nerd Font",
            fontsize=20,
            padding_x=10,
            spacing=3,
            borderwidth=3,
            active=colors[9],
            inactive=colors[15],
            center_aligned=True,
            rounded=False,
            highlight_color=colors[0],
            highlight_method="line",
            this_current_screen_border=colors[6],
            other_current_screen_border=colors[6],
        ),
        widget.Sep(
            padding=5,
            linewidth=0,
        ),
        widget.TextBox(
            text="",
            font="Iosevka Nerd Font",
            foreground=colors[14],
            fontsize=18,
        ),
        widget.Sep(
            padding=5,
            linewidth=0,
        ),
        widget.CurrentLayoutIcon(
            custom_icon_paths=[HOME + "/.config/qtile/icons"],
            scale=0.45,
            padding=0,
            font="Iosevka Nerd Font",
            fontsize=15,
        ),
        widget.CurrentLayout(
            font="Hack Nerd Font",
            fontsize=15,
            foreground=colors[8],
        ),
        widget.Spacer(
            length=bar.STRETCH,
        ),
        widget.Wttr(
            foreground=colors[1],
            location={
                'beijing': 'beijing',
            },
            format="%c %t %h",
            font="Hack Nerd Font",
            fontsize=15,
        ),
        widget.Sep(
            padding=5,
            linewidth=0,
        ),
        widget.TextBox(
            text="",
            font="Iosevka Nerd Font",
            foreground=colors[14],
            fontsize=18,
        ),
        widget.Sep(
            padding=5,
            linewidth=0,
        ),
        widget.Net(
            interface='wlp88s0',
            font="Hack Nerd Font",
            fontsize=15,
            format=' {down}',
            foreground=colors[1],
        ),
        widget.Sep(
            padding=5,
            linewidth=0,
        ),
        widget.TextBox(
            text="墳 ",
            font="Iosevka Nerd Font",
            fontsize=20,
            foreground=colors[13],
        ),
        widget.PulseVolume(
            cardid="SPA33",
            foreground=colors[1],
            limit_max_volume="True",
            mouse_callbacks={"Button3": lambda: qtile.cmd_spawn("pavucontrol")},
            font="Hack Nerd Font",
            fontsize=15,
        ),
        widget.Sep(
            padding=5,
            linewidth=0,
        ),
        widget.TextBox(
            text="",
            font="Iosevka Nerd Font",
            foreground=colors[14],
            fontsize=18,
        ),
        widget.Sep(
            padding=5,
            linewidth=0,
        ),
        widget.Sep(
            padding=5,
            linewidth=0,
        ),
        widget.TextBox(
            text=" ",
            font="Iosevka Nerd Font",
            fontsize=20,
            padding=0,
            foreground=colors[10],
        ),
        widget.Clock(
            font="Hack Nerd Font",
            foreground=colors[1],
            fontsize=15,
            format="%d %b, %A, %I:%M %p",
            mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(BIN+"/cal.sh")},
        ),
        widget.Sep(
            padding=10,
            linewidth=0,
        ),
    ]


# Spawn bar at multiple screens.
screens = [
    Screen(
        wallpaper="~/Pictures/Wallpapers/wallpaper.jpg",
        wallpaper_mode="fill",
        top=bar.Bar(
            top_bar(),
            size=35,
            opacity=0.9,
            background=colors[0],
            margin=[8, 8, 0, 8],
        ),
    ),
]


# Mod + Mouse drag -> Floating
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
wmname = "Qtile"
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
dgroups_app_rules = []  # type: List
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
    subprocess.call([BIN + "/autostart.sh"])

