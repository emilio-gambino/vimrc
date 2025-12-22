# Print time in dwm bar
xsetroot -name "$( date +"%F %R" )" &
while true; do
  xsetroot -name "$( date +"%F %R" )"
  sleep 2s
done &

setxkbmap fr

# Put caps key as escape
setxkbmap -option caps:escape

# Cursor delay and repeat rate
xset r rate 300 40

# Adjust monitors
xrandr --output HDMI-A-1 --right-of DisplayPort-3
xrandr --output DisplayPort-3 --brightness 0.9

exec dwm
