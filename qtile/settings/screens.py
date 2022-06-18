
from libqtile.config import Screen
from libqtile import bar, widget

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    active = "#ED4C67",
                    border_width = 1,
                    disable_drag = True,
                    fontsize = 15,
                    highlight_method = "line",
                    inactive = "#7f8fa6"
                ),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Clock(format="%d-%m-%Y %a %I:%M %p"),
                widget.Systray(),
                widget.CurrentLayoutIcon(
                    fontsize = 10
                ),
            ],
            25,
            background = "#000000"
        ),
    ),
]
