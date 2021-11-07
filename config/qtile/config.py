import os
import subprocess
from colors import colors
from screens import screens

from libqtile.config import (
    Key,
    Group,
    Drag,
)

from libqtile.command import lazy
from libqtile import layout, hook
from typing import List  # noqa: F401


mod = "mod1"
mod1 = "mod4"


@hook.subscribe.client_new
def set_floating(window):
    if (window.window.get_wm_transient_for()
            or window.window.get_wm_type() in floating_types):
        window.floating = True


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])


floating_types = ["notification", "toolbar", "splash", "dialog"]

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
    Key([mod, mod1], "k", lazy.layout.flip_up()),
    Key([mod, mod1], "j", lazy.layout.flip_down()),
    Key([mod, mod1], "l", lazy.layout.flip_right()),
    Key([mod, mod1], "h", lazy.layout.flip_left()),
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
    Key([mod], "n", lazy.layout.reset()),
    Key([mod], "m", lazy.layout.maximize()),
    Key([mod, "shift"], "f", lazy.window.toggle_fullscreen()),
]

# Command to find out wm_class of window: xprop | grep WM_CLASS
workspaces = [
    {"name": "1", "key": "1", "label": "", "layout": "monadtall"},
    {"name": "2", "key": "2", "label": "", "layout": "monadwide"},
    {"name": "3", "key": "3", "label": "", "layout": "matrix"},
    {"name": "4", "key": "4", "label": "", "layout": "bsp"},
    {"name": "5", "key": "5", "label": "", "layout": "max"},
]
groups = []
for workspace in workspaces:
    groups.append(
        Group(
            workspace["name"],
            layout=workspace["layout"],
            label=workspace["label"],
        ))
    keys.extend([
        Key([mod], workspace["key"], lazy.group[workspace["name"]].toscreen()),
        Key([mod, "shift"], workspace["key"],
            lazy.window.togroup(workspace["name"]),
            lazy.group[workspace["name"]].toscreen()),
    ])


def init_layout_theme():
    return {"margin": 5,
            "border_width": 2,
            "border_focus": "#5e81ac",
            "border_normal": "#4c566a"
            }


layout_theme = init_layout_theme()

layouts = [
    layout.MonadTall(margin=8, border_width=2, border_focus="#5e81ac", border_normal="#4c566a"),
    layout.MonadWide(margin=8, border_width=2, border_focus="#5e81ac", border_normal="#4c566a"),
    layout.Matrix(**layout_theme),
    layout.Bsp(**layout_theme),
    layout.Floating(**layout_theme),
    layout.RatioTile(**layout_theme),
    layout.Max(**layout_theme)
]


# Setup bar
widget_defaults = dict(font="JetBrainsMono Nerd Font Mono Medium",
                       fontsize=18,
                       padding=3,
                       background=colors[0])
extension_defaults = widget_defaults.copy()

# MOUSE CONFIGURATION
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = "floating_only"
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "focus"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "compiz"
