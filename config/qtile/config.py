import os
import subprocess

from colors import colors
from screens import screens

from os import environ

from libqtile.config import (
    # KeyChord,
    Key,
    # Screen,
    Group,
    Drag,
    Click,
    ScratchPad,
    DropDown,
    Match,
)

from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
# from libqtile import qtile
# from typing import List  # noqa: F401
from custom.bsp import Bsp as CustomBsp
from custom.bsp import Bsp as CustomBspMargins
from custom.zoomy import Zoomy as CustomZoomy
# from custom.stack import Stack as CustomStack
# from custom.windowname import WindowName as CustomWindowName

mod = "mod1"
mod1 = "mod4"
terminal = "/opt/app/bin/kitty"


@hook.subscribe.client_new
def floating_dialogs(window):
    dialog = window.window.get_wm_type() == 'tk'
    transient = window.window.get_wm_transient_for()
    if dialog or transient:
        window.floating = True


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])


## Resize functions for bsp layout
def resize(qtile, direction):
    layout = qtile.current_layout
    child = layout.current
    parent = child.parent

    while parent:
        if child in parent.children:
            layout_all = False

            if (direction == "left" and parent.split_horizontal) or (
                    direction == "up" and not parent.split_horizontal):
                parent.split_ratio = max(
                    5, parent.split_ratio - layout.grow_amount)
                layout_all = True
            elif (direction == "right" and parent.split_horizontal) or (
                    direction == "down" and not parent.split_horizontal):
                parent.split_ratio = min(
                    95, parent.split_ratio + layout.grow_amount)
                layout_all = True

            if layout_all:
                layout.group.layout_all()
                break

        child = parent
        parent = child.parent


@lazy.function
def resize_left(qtile):
    resize(qtile, "left")


@lazy.function
def resize_right(qtile):
    resize(qtile, "right")


@lazy.function
def resize_up(qtile):
    resize(qtile, "up")


@lazy.function
def resize_down(qtile):
    resize(qtile, "down")


keys = [
    Key(
        [mod],
        "p",
        lazy.spawn("/home/liubang/.config/rofi/launchers/colorful/launcher.sh"),
    ),
    Key(
        [mod],
        "w",
        lazy.spawn("rofi -show window"),
    ),
    Key(
        [mod],
        "Return",
        lazy.spawn(terminal + " -e --single-instance"),
        desc="Launch terminal",
    ),
    Key(
        [mod],
        "Tab",
        lazy.next_layout(),
        desc="Toggle through layouts",
    ),
    Key(
        [mod, "shift"],
        "c",
        lazy.window.kill(),
        desc="Kill focused window",
    ),
    Key(
        [mod, "shift"],
        "q",
        lazy.spawn("xkill"),
        desc="Force kill window",
    ),
    Key(
        [mod, "shift"],
        "r",
        lazy.restart(),
        desc="Restart Qtile",
    ),
    Key(
        [mod, "shift"],
        "Escape",
        lazy.shutdown(),
        desc="Shutdown Qtile",
    ),
    Key(
        [mod, "shift"],
        "a",
        lazy.spawn("/usr/bin/flameshot gui"),
        desc="Launches flameshot",
    ),
    ### Window controls
    Key(
        [mod],
        "j",
        lazy.layout.down(),
        desc="Move focus down in current stack pane",
    ),
    Key(
        [mod],
        "k",
        lazy.layout.up(),
        desc="Move focus up in current stack pane",
    ),
    Key(
        [mod],
        "h",
        lazy.layout.left(),
        lazy.layout.next(),
        desc="Move focus left in current stack pane",
    ),
    Key(
        [mod],
        "l",
        lazy.layout.right(),
        lazy.layout.previous(),
        desc="Move focus right in current stack pane",
    ),
    Key(
        [mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move windows down in current stack",
    ),
    Key(
        [mod, "shift"],
        "k",
        lazy.layout.shuffle_up(),
        desc="Move windows up in current stack",
    ),
    Key(
        [mod, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move windows left in current stack",
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move windows right in the current stack",
    ),
    Key(
        [mod, mod1],
        "j",
        lazy.layout.flip_down(),
        desc="Flip layout down",
    ),
    Key(
        [mod, mod1],
        "k",
        lazy.layout.flip_up(),
        desc="Flip layout up",
    ),
    Key(
        [mod, mod1],
        "h",
        lazy.layout.flip_left(),
        desc="Flip layout left",
    ),
    Key(
        [mod, mod1],
        "l",
        lazy.layout.flip_right(),
        desc="Flip layout right",
    ),
    Key(
        [mod],
        "comma",
        resize_left,
        desc="Resize window left",
    ),
    Key(
        [mod],
        "period",
        resize_right,
        desc="Resize window Right",
    ),
    Key(
        [mod],
        "semicolon",
        resize_up,
        desc="Resize windows upward",
    ),
    Key(
        [mod],
        "apostrophe",
        resize_down,
        desc="Resize windows downward",
    ),
    Key(
        [mod],
        "n",
        lazy.layout.normalize(),
        desc="Normalize window size ratios",
    ),
    Key(
        [mod],
        "m",
        lazy.layout.maximize(),
        desc="Toggle window between minimum and maximum sizes",
    ),
    Key(
        [mod, "shift"],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen",
    ),
    Key(
        [mod],
        "f",
        lazy.window.toggle_floating(),
        desc="Toggle floating on focused window",
    ),
    Key(
        [],
        "XF86AudioNext",
        lazy.spawn("playerctl next"),
        desc="Play next audio",
    ),
    Key([],
        "XF86AudioPlay",
        lazy.spawn("playerctl play-pause"),
        desc="Toggle play/pause audio"),
    Key(
        [],
        "XF86AudioPrev",
        lazy.spawn("playerctl previous"),
        desc="Play previous audio",
    ),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn("amixer -q -D pulse sset Master toggle"),
        desc="Mute audio",
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +1%"),
        desc="Raise volume",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -1%"),
        desc="Lower volume",
    ),
    Key([mod],
        "grave",
        lazy.group['scratchpad'].dropdown_toggle("term"),
        desc="Toggle scratchpad")
]

# Command to find out wm_class of window: xprop | grep WM_CLASS
workspaces = [
    {
        "name": "1",
        "key": "1",
        "label": "",
        "layout": "bsp",
        "matches": [],
        "spawn": [],
    },
    {
        "name": "2",
        "key": "2",
        "label": "",
        "layout": "bsp",
        "matches": [],
        "spawn": [],
    },
    {
        "name": "3",
        "key": "3",
        "label": "",
        "layout": "max",
        "matches": [
            Match(wm_class="ncmpcpp"),
            Match(wm_class="yesplaymusic"),
            Match(wm_class="netease-cloud-music"),
        ],
        "spawn": [],
    },
    {
        "name": "4",
        "key": "4",
        "label": "",
        "layout": "bsp",
        "matches": [
            Match(wm_class="VirtualBox Manager"),
            Match(wm_class="VirtualBox Machine"),
            Match(wm_class="Vmware"),
        ],
        "spawn": [],
    },
    {
        "name": "5",
        "key": "5",
        "label": "",
        "layout": "max",
        "matches": [
            Match(wm_class="qbittorrent"),
            Match(wm_class="postman"),
        ],
        "spawn": [],
    },
]

groups = []
for workspace in workspaces:
    matches = workspace["matches"] if "matches" in workspace else None
    groups.append(
        Group(
            workspace["name"],
            matches=matches,
            layout=workspace["layout"],
            spawn=workspace["spawn"],
            label=workspace["label"],
        ))
    keys.append(
        Key(
            [mod],
            workspace["key"],
            lazy.group[workspace["name"]].toscreen(),
            desc="Focus certain workspace",
        ))
    keys.append(
        Key(
            [mod, "shift"],
            workspace["key"],
            lazy.window.togroup(workspace["name"]),
            desc="Move focused window to another workspace",
        ))

groups.append(ScratchPad("scratchpad", [
    DropDown("term", "st", opacity=0.8),
]))

layout_theme = {
    "border_width": 3,
    "margin": 5,
    "border_focus": "fafafa",
    "border_normal": "fafafa",
    "font": "FiraCode Nerd Font",
    "grow_amount": 4,
}

layout_theme_margins = {
    "name": "bsp-margins",
    "border_width": 3,
    "margin": [150, 300, 150, 300],
    "border_focus": "fafafa",
    "border_normal": "fafafa",
    "font": "FiraCode Nerd Font",
    "grow_amount": 4,
}

layout_audio = {
    "name": "monadwide-audio",
    "border_width": 3,
    "margin": 100,
    "border_focus": "fafafa",
    "border_normal": "fafafa",
    "font": "FiraCode Nerd Font",
    "ratio": 0.65,
    "new_client_position": "after_current",
}

layouts = [
    # layout.Bsp(**layout_theme, fair=False),
    CustomBsp(**layout_theme, fair=False),
    layout.Max(**layout_theme),
    layout.TreeTab(
        **layout_theme,
        active_bg=colors[1],
        active_fg=colors[0],
        bg_color=colors[1],
        fontsize=16,
        inactive_bg=colors[1],
        inactive_fg=colors[0],
        sections=["", "", ""],
        section_fontsize=18,
        section_fg=colors[0],
    ),
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    # layout.Columns(
    #    **layout_theme,
    #    border_on_single=True,
    #    num_columns=3,
    #    # border_focus_stack=colors[2],
    #    # border_normal_stack=colors[2],
    #    split=False,
    # ),
    # layout.RatioTile(**layout_theme),
    # layout.VerticalTile(**layout_theme),
    # layout.Matrix(**layout_theme, columns=3),
    # layout.Slice(**layout_theme),
    # layout.Tile(shift_windows=True, **layout_theme),
    #layout.Floating(**layout_theme),
    #CustomBspMargins(**layout_theme_margins),
]

# Setup bar

widget_defaults = dict(font="JetBrainsMono Nerd Font Mono Medium",
                       fontsize=18,
                       padding=3,
                       background=colors[0])
extension_defaults = widget_defaults.copy()

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag([mod],
         "Button3",
         lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
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
