# start i3 window manager
exec dbus-launch i3

# for dpi
xrdb -merge ~/.Xresources

xrandr --output eDP1 --scale 0.75x0.75
