import os

from libqtile.config import (
    Screen,
)
from libqtile import bar, widget  # , hook, layout
from libqtile import qtile

from colors import colors


def open_pavu():
    qtile.cmd_spawn("pavucontrol")


text_size = 18
icon_size = 14

screens = [
    Screen(
        wallpaper="~/Pictures/wallpaper.png",
        wallpaper_mode="fill",
        top=bar.Bar(
            [
                widget.Sep(
                    linewidth=0,
                    background=colors[1],
                    padding=20,
                    size_percent=40,
                ),
                widget.GroupBox(
                    font="Hack Nerd Font",
                    padding=3,
                    borderwidth=4,
                    active=colors[9],
                    inactive=colors[10],
                    disable_drag=True,
                    rounded=True,
                    highlight_color=colors[2],
                    block_highlight_text_color=colors[8],
                    highlight_method="block",
                    this_current_screen_border=colors[1],
                    this_screen_border=colors[7],
                    other_current_screen_border=colors[1],
                    other_screen_border=colors[1],
                    foreground=colors[0],
                    background=colors[1],
                    urgent_border=colors[3],
                    fontsize=12,
                ),
                widget.Sep(
                    linewidth=0,
                    background=colors[1],
                    padding=10,
                    size_percent=40,
                ),
                widget.CurrentLayoutIcon(
                    custom_icon_paths=[
                        os.path.expanduser("~/.config/qtile/icons")
                    ],
                    foreground=colors[8],
                    background=colors[1],
                    padding=-2,
                    scale=0.45,
                ),
                widget.Sep(
                    linewidth=0,
                    background=colors[1],
                    padding=10,
                    size_percent=50,
                ),
                widget.Systray(
                    padding=10,
                    foreground=colors[8],
                    background=colors[1],
                ),
                widget.TextBox(
                    background=colors[1],
                    foreground=colors[3],
                    text="",
                    font="Font Awesome 5 Free Solid",
                    padding=15,
                ),
                widget.WindowName(
                    background=colors[1],
                    foreground=colors[0],
                    max_chars=30,
                ),
                widget.Spacer(
                    background=colors[1],
                ),
                widget.Sep(
                    linewidth=0,
                    padding=10,
                    size_percent=50,
                    background=colors[1],
                ),
                widget.TextBox(
                    background=colors[1],
                    foreground=colors[11],
                    text=" ",
                    font="Font Awesome 5 Free Solid",
                    fontsize=icon_size,
                ),
                widget.Net(
                    background=colors[1],
                    foreground=colors[0],
                    format="{down}",
                    fontsize=text_size,
                ),
                widget.Sep(
                    background=colors[1],
                    linewidth=0,
                    padding=10,
                    size_percent=50,
                ),
                widget.TextBox(
                    text=" ",
                    font="Font Awesome 5 Free Solid",
                    background=colors[1],
                    foreground=colors[11],
                    fontsize=icon_size,
                ),
                widget.Wlan(
                    interface="wlp88s0",
                    format="{essid}",
                    background=colors[1],
                    foreground=colors[0],
                    padding=5,
                    fontsize=text_size,
                    # mouse_callbacks={"Button1": open_connman},
                ),
                widget.Sep(
                    linewidth=0,
                    padding=10,
                    size_percent=50,
                    background=colors[1],
                ),
                widget.TextBox(
                    background=colors[1],
                    foreground=colors[8],
                    text=" ",
                    font="Font Awesome 5 Free Solid",
                    fontsize=icon_size,
                ),
                widget.PulseVolume(
                    background=colors[1],
                    foreground=colors[0],
                    limit_max_volume="True",
                    update_interval=0.1,
                    mouse_callbacks={"Button3": open_pavu},
                    fontsize=text_size,
                ),
                widget.Sep(
                    background=colors[1],
                    linewidth=0,
                    padding=10,
                    size_percent=50,
                ),
                widget.TextBox(
                    background=colors[1],
                    foreground=colors[7],
                    text="",
                    font="Font Awesome 5 Free Solid",
                    fontsize=icon_size,
                ),
                widget.CPU(
                    background=colors[1],
                    foreground=colors[0],
                    update_interval=1,
                    format="{load_percent: .0f} %",
                    fontsize=text_size,
                ),
                widget.Sep(
                    background=colors[1],
                    linewidth=0,
                    padding=10,
                    size_percent=50,
                ),
                widget.TextBox(
                    text="",
                    font="Font Awesome 5 Free Solid",
                    background=colors[1],
                    foreground=colors[6],
                    fontsize=icon_size,
                ),
                widget.Memory(
                    background=colors[1],
                    foreground=colors[0],
                    format="{MemPercent: .0f} %",
                    fontsize=text_size,
                ),
                widget.Sep(
                    background=colors[1],
                    linewidth=0,
                    padding=10,
                    size_percent=50,
                ),
                widget.TextBox(
                    background=colors[1],
                    foreground=colors[4],
                    text=" ",
                    font="Font Awesome 5 Free Solid",
                    fontsize=14,
                ),
                widget.Clock(
                    background=colors[1],
                    foreground=colors[0],
                    format="%m/%d %A %H:%M:%S",
                    fontsize=text_size,
                ),
                widget.Sep(
                    background=colors[1],
                    linewidth=0,
                    padding=10,
                    size_percent=50,
                ),
                widget.Wttr(
                    background=colors[1],
                    foreground=colors[0],
                    location={
                        'beijing': 'beijing',
                    },
                    format="%c %t %h",
                    fontsize=text_size,
                ),
                widget.Sep(
                    background=colors[1],
                    linewidth=0,
                    padding=25,
                    size_percent=50,
                ),
            ],
            32,
            margin=[0, -10, 5, -10],
        ),
        bottom=bar.Gap(5),
        left=bar.Gap(5),
        right=bar.Gap(5),
    ),
]
