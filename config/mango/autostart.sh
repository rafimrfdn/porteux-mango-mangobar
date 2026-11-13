# ~/.config/mango/autostart.sh
#!/bin/sh
pipewire &
sleep 1
wireplumber &
pipewire-pulse &
