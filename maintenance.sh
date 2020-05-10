#!/bin/bash

rouge='\e[1;31m'
jaune='\e[1;33m' 
bleu='\e[1;34m' 
violet='\e[1;35m' 
vert='\e[1;32m'
neutre='\e[0;m'

if [ "$UID" -eq "0" ]
then
    zenity --warning --height 80 --width 400 --title "EREUR" --text "Merci de lancez le script sans sudo : \n<b>./maintenance.sh</b>\nVous devrez entrer le mot de passe root par la suite."
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
    echo -e -n "$rouge MISE A JOUR "
    for i in `seq 14 $COLUMNS`;
        do echo -n "."
    done
    echo -e " $neutre"
    notify-send -i system-software-update "Maintenance d'Ubuntu" "Mise à jour" -t 500
    sudo dpkg --configure -a
    sudo apt update
    sudo apt full-upgrade -y
    echo " "
    echo -e -n "$rouge AUTO-REMOVE "
        for i in `seq 14 $COLUMNS`;
        do echo -n "."
    done
    echo -e " $neutre"
    notify-send -i system-software-update "Maintenance d'Ubuntu" "Auto-remove" -t 500
    sudo apt autoremove --purge -y
    echo " "
    echo -e -n "$rouge CLEAN "
        for i in `seq 8 $COLUMNS`;
        do echo -n "."
    done
    echo -e " $neutre"
    notify-send -i system-software-update "Maintenance d'Ubuntu" "Clean" -t 500
    sudo apt autoclean
    echo " "
    echo -e -n "$rouge PURGE "
        for i in `seq 8 $COLUMNS`;
        do echo -n "."
    done
    echo -e " $neutre"
    notify-send -i system-software-update "Maintenance d'Ubuntu" "Purge" -t 500

    which localepurge > /dev/null
    if [ $? = 1 ]
    then
	    sudo apt install -y localepurge
    fi

    sudo localepurge

    sudo apt purge $(COLUMNS=200 dpkg -l | grep "^rc" | tr -s ' ' | cut -d ' ' -f 2) -y
    echo " "
    echo -e -n "$rouge NETTOYAGE DES SNAPS "
        for i in `seq 22 $COLUMNS`;
        do echo -n "."
    done
    echo -e " $neutre"
    notify-send -i system-software-update "Maintenance d'Ubuntu" "Nettoyage des snaps" -t 500
    sudo snap refresh
    echo "" 
    echo -e -n "$rouge RESOLUTION DES DEPENDANCES "
        for i in `seq 29 $COLUMNS`;
        do echo -n "."
    done
    echo -e " $neutre"
    notify-send -i system-software-update "Maintenance d'Ubuntu" "Réparation des dépendances" -t 500
    sudo apt install -fy
    echo ""
    TRASH=$(date --date="1 week ago" "+%d %B")
    echo -e -n "$rouge FICHIERS ANTERIEURS AU $TRASH "
        for i in `seq 34 $COLUMNS`;
        do echo -n "."
    done
    echo -e " $neutre"
    notify-send -i system-software-update "Maintenance d'Ubuntu" "Suppression des fichiers de la corbeille antérieurs au $TRASH" -t 500
    echo ""

    which trash-cli > /dev/null
    if [ $? = 1 ]
    then
        sudo apt install -y trash-cli
    fi

    for i in `seq 0 30`;
        do trash-list | grep $(date --date="$i day ago" "+%Y-%m-%d")
    done

    zenity --question --height 40 --width 300 --title "Maintenance d'Ubuntu" --text "Voulez-vous supprimer les fichiers de la corbeille antérieurs au <b>$TRASH</b> ?"
    if [ $? == 0 ] 
	then
	    trash-empty 7
	fi
    notify-send -i dialog-ok "Maintenance d'Ubuntu" "Terminée avec succès" -t 500

else
    echo ""
    echo -e -n "$rouge MISE A JOUR "
    for i in `seq 14 $COLUMNS`;
        do echo -n "."
    done
    echo -e " $neutre"
    notify-send -i system-software-update "Maintenance d'Ubuntu" "Mise à jour" -t 500
    sudo apt update
    sudo apt full-upgrade -y
    notify-send -i dialog-ok "Maintenance d'Ubuntu" "Terminée avec succès" -t 500
fi
