# chrootbuilder
chroot envo builder


. $ ./chroot.sh /bin/{ls,cat,nano,echo,rm,sh} /usr/bin/vi /etc/hosts

# manual add 
. $ sudo groupadd chrootjail
. $ sudo adduser user chrootjail


# Configure sshd for chroot jail

* All what remains is to configure sshd to automaticaly redirect all users from the chrootjail usergroup to the chroot jail at /var/chroot. This can be easily done be editing the sshd configuration file /etc/ssh/sshd_config. Add the following to /etc/ssh/sshd_config:

Match group chrootjail
            ChrootDirectory /var/chroot/

* and restarting ssh:

$ sudo service ssh restart

$ ssh user@localhost


