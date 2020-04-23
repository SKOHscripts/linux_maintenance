#!/bin/bash

# Vérification que le script n'est pas lancé directement avec sudo (le script contient déjà les sudos pour les actions lorsque c'est nécessaire)
if [ "$UID" -eq "0" ]
then
    zenity --warning --height 80 --width 400 --title "EREUR" --text "Merci de ne pas lancer le script avec sudo (./maintenance.sh), vous donnerez votre mot de passe par la suite."
    exit
fi

which notify-send > /dev/null
if [ $? = 1 ]
then
	sudo apt install -y libnotify-bin
fi

which zenity > /dev/null
if [ $? = 1 ]
then
	sudo apt install -y zenity
fi

zenity --question --no-wrap --height 40 --width 300 --title  "Maintenance d'Ubuntu" --text "Lancer la maintenance complète ?"

if [ $? == 0 ] 
then
    echo ""
    echo "======MISE A JOUR======"
    echo " "
    notify-send -i system-software-update "Maintenance d'Ubuntu" "Mise à jour" -t 500
    sudo dpkg --configure -a
    sudo apt update
    sudo apt full-upgrade -y
    echo " "
    echo "======AUTO-REMOVE======"
    echo " "
    notify-send -i system-software-update "Maintenance d'Ubuntu" "Auto-remove" -t 500
    sudo apt autoremove --purge -y
    echo " "
    echo "======CLEAN======"
    echo " "
    notify-send -i system-software-update "Maintenance d'Ubuntu" "Clean" -t 500
    sudo apt autoclean
    echo " "
    echo "======PURGE======"
    echo " "
    notify-send -i system-software-update "Maintenance d'Ubuntu" "Purge" -t 500

    which localepurge > /dev/null
    if [ $? = 1 ]
    then
	    sudo apt install -y localepurge
    fi

    sudo localepurge

    sudo apt purge $(COLUMNS=200 dpkg -l | grep "^rc" | tr -s ' ' | cut -d ' ' -f 2)
    echo " "
    echo "======NETTOYAGE DES SNAPS======"
    echo " "
    notify-send -i system-software-update "Maintenance d'Ubuntu" "Nettoyage des snaps" -t 500
    sudo snap refresh
    sudo apt clean && snap list --all | awk 'BEGIN {print "#! /bin/sh\n"} ; /désactivé|disabled/ {print "snap remove "$1" --revision "$3"\n"} ; END {print "exit 0"}' > script && chmod +x script && ./script && rm script && echo && snap list --all && echo && df -Th | grep -Ev "tmpfs|squashfs"
    echo "" 
    echo "======RESOLUTION DES DEPENDANCES======"
    echo " "
    notify-send -i system-software-update "Maintenance d'Ubuntu" "Réparation des dépendances" -t 500
    sudo apt install -fy
    echo ""
    twoweeks=$(date --date="2 week ago" "+%d %B")
    echo "======FICHIERS ANTERIEURS AU $twoweeks======"
    echo " "
    notify-send -i system-software-update "Maintenance d'Ubuntu" "Suppression des fichiers de la corbeille antérieurs au $twoweeks" -t 500
    echo ""

    which trash-cli > /dev/null
    if [ $? = 1 ]
    then
        sudo apt install -y trash-cli
    fi

    trash-list
    zenity --question --height 40 --width 300 --title "Maintenance d'Ubuntu" --text "Voulez-vous supprimer les fichiers de la corbeille antérieurs au $twoweeks ?"
    if [ $? == 0 ] 
	then
	    trash-empty 31
	fi
    notify-send -i dialog-ok "Maintenance d'Ubuntu" "Terminée avec succès" -t 500

else
    notify-send -i system-software-update "Maintenance d'Ubuntu" "Mise à jour" -t 500
    sudo apt update
    sudo apt full-upgrade -y
    notify-send -i dialog-ok "Maintenance d'Ubuntu" "Terminée avec succès" -t 500
fi
