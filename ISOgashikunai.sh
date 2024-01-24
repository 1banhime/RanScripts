#!/bin/bash

#mount iso and

echo "install option 1... 2... "
echo "WARNING!: WILL REBOOT YOUR SYSTEM"  
read -p "Pick your poison: " option

path=""
#replace ISOSTICKY with the name of your usb device
case $option in    
    1)
        path="/media/"$USER"/ISOSTICKY/ISOs/1.iso"
        ;;

    2)
        path="/media/"$USER"/ISOSTICKY/ISOs/2.iso"
        ;;

    *)
        echo "Invalid"
        exit 1
        ;;
esac

sudo mount -o loop $path /mnt

echo "Rebooting your system now :3"

reboot

#AI KOTOBA NO 1BANHIME
