# irssi via ssh notifier for OS-X

These scripts will allow you to get desktop notifications in OS-X by monitoring an irssi session through ssh.

Most credit goes to [James](http://ttboj.wordpress.com/2013/10/18/desktop-notifications-for-irssi-in-screen-through-ssh-in-gnome-terminal/). I just modified this so it will work with OS-X instead of GNOME.

## Directions

#### On your ssh server (with irssi)

```
mkdir -p ~/.irssi/scripts
```

Copy the `fnotify.pl` into `~/.irssi/scripts`

```
irssi> /load perl
irssi> /script load fnotify
```

When someone sends you a direct message, or highlights your nick on IRC, this script will append a line to the `~/.irssi/notify` file on the SSH server

#### On your OS-X desktop

```
mkdir ~/bin
```

Copy the `irssi-fnotify.sh` script into `~/bin`

We want the `irssi-fnotify.sh` script to run automatically when we connect to our SSH server. To do this, add the following lines to your `~/.ssh/config` file (create if it doesnt exist):

```
# irc
Host irc
    HostName irc.myserver.com
    PermitLocalCommand yes
    LocalCommand ~/bin/irssi-fnotify.sh --start %r@%h
```

Now each time you run:

```
ssh irc
```

The `irssi-fnotify.sh` command will automatically run.
