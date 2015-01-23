# !/bin/bash
#
#  Copyright (C) 2014
#  Ken Dresdell
#  All Rights Reserved
#
#
#  Last update 2015-01-22



UpdateOS(){
	header "Installateur de boutique en ligne"
	title "Mise a jour du OS"
	apt-get update  -qy
	apt-get upgrade -qy
}

Set_Hostname(){
	header "Installateur de boutique en ligne"
	title "Setup Server Hosname"
	echo -n "Please enter your hostname FQDN :"
	read hostname
    echo $hostname > /etc/hostname
    hostname $hostname
}



Set_SSH(){
	header "Installateur de boutique en ligne"
    title "Setup SSH-Server on TCP 2222"
    apt-get install -qy openssh-server
    sed -i "s/^Port 22$/Port 2222/g" /etc/ssh/sshd_config
    service ssh restart 
}



Set_Mail(){
	header "Installateur de boutique en ligne"
	title "Installation service MAIL Sortant"
	apt-get install -qy postfix mailutils
	#dpkg-reconfigure postfix
	echo "kdresdell@gmail.com" > /root/.forward

	postconf -e "relayhost = [smtp.gmail.com]:587"
	postconf -e "smtp_use_tls=yes"
	postconf -e "smtp_sasl_auth_enable = yes"
	postconf -e "smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd"
	postconf -e "smtp_sasl_security_options ="
	postconf -e "smtp_generic_maps = hash:/etc/postfix/generic"
	echo "[smtp.gmail.com]:587 kdresdell@gmail.com:mFrance&2012phileli" > /etc/postfix/sasl_passwd
	chown root:root /etc/postfix/sasl_passwd
	chmod 600 /etc/postfix/sasl_passwd
	postmap /etc/postfix/sasl_passwd
	echo "root@localhost ken@dresdell.com" >>/etc/postfix/generic 
	postmap /etc/postfix/generic
	service postfix restart
}


Set_Fail2ban(){
	header "Installateur de boutique en ligne"
	title "Installation service Fail2Ban"
	apt-get install -qy fail2ban
	title "Backup des configurations"
	mv /etc/fail2ban/jail.conf /etc/fail2ban/_jail.conf.origin 

	cp conf/fail2ban/wordpress-auth.conf /etc/fail2ban/filter.d/
	cp conf/fail2ban/jail.conf /etc/fail2ban/
	service fail2ban restart
}


Set_Firewall(){
	header "Installateur de boutique en ligne"
	title "Installation service de Firewall"
	cp -i bin/firewall.sh /etc/
	title "Activation du firewall au reboot"
	chmod +x /etc/firewall.sh
	sed -i '\/etc\/firewall.sh/d' /etc/rc.local
	sed -i -e '$i \/etc/firewall.sh' /etc/rc.local
}





source lib/lib.sh
##################################################################
#
#
#    PROGRAMME PRINCIPAL
#
#
##################################################################


VERSION="0.1"
ARG=$1


header "Install Script for Small PBX"



if [ "$ARG" == "all" ]; then
	Set_Mail
else 
	echo -n "Set_Mail (y/n) :"
	read a
	if [ "$a" == "y" ]; then
		Set_Mail
	fi
fi


apt-get install build-essential subversion libncurses-dev libssl-dev libxml2-dev sqlite3 libsqlite3-dev uuid uuid-dev libjansson-dev

#wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-13-current.tar.gz


tar zxvf asterisk-13-current.tar.gz
cd asterisk-13.1.0


contrib/scripts/install_prereq install
#contrib/scripts/get_mp3_source.sh

./configure
make menuselect
make
make install
#make samples
make config


#     vim-nox 
#   
#     libiksemel-dev 
# #
#
#     mpg123 
#     unixodbc 
#     libcurl3 
#     uuid 
#     uuid-dev 
#     xslt-dev 
#     jansson-dev 
#     libjansson-dev
     
#apt-get install build-essential zlib1g-dev libxml2-dev libncurses-dev libnewt-dev \
#linux-headers-$(uname -r) libmysqlclient-dev libsqlite3-dev libssl-dev subversion wget
