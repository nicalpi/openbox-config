# This shell script is run before Openbox launches.
# Environment variables set here are passed to the Openbox session.

# Set a background color
BG=""
if which hsetroot >/dev/null; then
    BG=hsetroot
else
    if which esetroot >/dev/null; then
	BG=esetroot
    else
	if which xsetroot >/dev/null; then
	    BG=xsetroot
	fi
    fi
fi
test -z $BG || $BG -solid "#303030"

# D-bus
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi

# Make GTK apps look and behave how they were set up in the gnome config tools
if test -x /usr/libexec/gnome-settings-daemon >/dev/null; then
  /usr/libexec/gnome-settings-daemon &
elif which gnome-settings-daemon >/dev/null; then
  gnome-settings-daemon &
# Make GTK apps look and behave how they were set up in the XFCE config tools
elif which xfce-mcs-manager >/dev/null; then
  xfce-mcs-manager n &
fi

# Preload stuff for KDE apps
if which start_kdeinit >/dev/null; then
  LD_BIND_NOW=true start_kdeinit --new-startup +kcminit_startup &
fi

# Run XDG autostart things.  By default don't run anything desktop-specific
# See xdg-autostart --help more info
DESKTOP_ENV="OPENBOX"
if which /usr/lib/openbox/xdg-autostart >/dev/null; then
  /usr/lib/openbox/xdg-autostart $DESKTOP_ENV
fi

if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; 
  then
   eval `dbus-launch --sh-syntax --exit-with-session`
   eval `ssh-agent`
fi




thunar --daemon &

nm-applet &

gnome-power-manager &

gnome-volume-control-applet &

bluetooth-applet &

update-notifier &

parcellite &


# Composite manager, pick which you prefer
xcompmgr &
#cairo-compmgr &

docky &

synapse &

(sleep 1 && tint2) &

(sleep 100 && dropbox start -i) & # Launch dropbo when system is loaded and internet is around.
(sleep 100 && /bin/sh -c '[ -d "$HOME/Ubuntu One" ] && ubuntuone-launch') & # Ubuntu one connect

nitrogen --restore &

/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

/usr/bin/gnome-keyring-daemon --start --components=ssh &

system-config-printer-applet &

ln -s /var/run/mysqld/mysqld.sock /tmp/mysql.sock &

pytyle2 &

