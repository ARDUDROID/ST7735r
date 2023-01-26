#!/usr/bin/env bash
    
# test root

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ ! $? = 0 ]; then
   exit 1
else

echo 'update'

sudo apt-get update

echo  'whiptail'

sudo apt install -y whiptail cmake git make 


echo 'rc.local'

sudo mv /home/kali/ST7735r/rc-local.service /etc/systemd/system/rc-local.service


sudo systemctl enable rc.local && sudo systemctl start rc.local 

echo 'clone'

git clone https://github.com/notro/fbtft

sudo mv modules /etc/
 
echo 'fbtft.conf'

sudo mv /home/kali/ST7735r/fbtft.conf /etc/modprobe.d/ 

echo  'fbcp'

git clone https://github.com/tasanakorn/rpi-fbcp
cd rpi-fbcp
mkdir build
cd build
cmake ..
make
sudo install fbcp /usr/local/bin/fbcp
cd ..
cd ..
echo 'rc.local'

sudo mv /home/kali/ST7735r/rc.local /etc/rc.local

echo '/boot/config.txt'

 sudo mv /home/kali/ST7735r/config.txt /boot/config.txt
 
# reboot system :))))

  whiptail --msgbox "The system will now reboot" 8 40
   reboot
fi