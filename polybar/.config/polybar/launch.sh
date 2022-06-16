#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar
polybar bottom &
dual_monitor=$(xrandr --query | grep 'HDMI-A-0')
if [[ $dual_monitor = *connected* ]]; then
    polybar bottom_external &
fi


echo "Polybar launched..."
