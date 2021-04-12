#!/bin/bash

rouge='\e[1;31m'
vert='\e[1;33m'
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
    echo -e -n "$vert [1/7]$rouge MISE A JOUR DES PAQUETS "
    for i in `seq 32 $COLUMNS`;
        do echo -n "."
    done
    echo -e " $neutre"
    notify-send -i system-software-update "Maintenance d'Ubuntu" "Mises à jour"
    sudo dpkg --configure -a
    sudo apt update
    sudo apt full-upgrade -y
    sudo apm upgrade
    echo " "

    echo -e -n "$vert [2/7]$rouge MISE A JOUR DES SNAPS "
    for i in `seq 30 $COLUMNS`;
        do echo -n "."
    done
    echo -e " $neutre"
    # notify-send -i system-software-update "Maintenance d'Ubuntu" "Mise à jour des snaps"
    snap list --all
    sudo snap refresh
    echo " "

    echo -e -n "$vert [3/7]$rouge AUTO-REMOVE "
        for i in `seq 20 $COLUMNS`;
        do echo -n "."
    done
    echo -e " $neutre"
    # notify-send -i system-software-update "Maintenance d'Ubuntu" "Auto-remove"
    sudo apt autoremove --purge -y
    echo " "

    echo -e -n "$vert [4/7]$rouge CLEAN "
        for i in `seq 14 $COLUMNS`;
        do echo -n "."
    done
    echo -e " $neutre"
    # notify-send -i system-software-update "Maintenance d'Ubuntu" "Clean"
    sudo apt autoclean
    echo " "

    echo -e -n "$vert [5/7]$rouge PURGE "
        for i in `seq 14 $COLUMNS`;
        do echo -n "."
    done
    echo -e " $neutre"
    # notify-send -i system-software-update "Maintenance d'Ubuntu" "Purge"

    sudo apt purge $(COLUMNS=200 dpkg -l | grep "^rc" | tr -s ' ' | cut -d ' ' -f 2) -y
    echo " "
    echo -e -n "$vert [6/7]$rouge RESOLUTION DES DEPENDANCES "
        for i in `seq 35 $COLUMNS`;
        do echo -n "."
    done
    echo -e " $neutre"
    # notify-send -i system-software-update "Maintenance d'Ubuntu" "Réparation des dépendances"
    sudo apt install -fy
    echo ""
    TRASH=$(date --date="3 week ago" "+%d %B")

    echo -e -n "$vert [7/7]$rouge FICHIERS ANTERIEURS AU $TRASH "
        for i in `seq 40 $COLUMNS`;
        do echo -n "."
    done
    echo -e " $neutre"
    # notify-send -i system-software-update "Maintenance d'Ubuntu" "Suppression des fichiers de la corbeille antérieurs au $TRASH"
    echo " "

    which trash-cli > /dev/null
    if [ $? = 1 ]
    then
        sudo apt install -y trash-cli
    fi

    for i in `seq 0 21`;
        do trash-list | grep $(date --date="$i day ago" "+%Y-%m-%d")
    done
    echo " "
    echo " "
    for i in `seq 21 60`;
        do trash-list | grep $(date --date="$i day ago" "+%Y-%m-%d")
    done

    zenity --question --height 40 --width 300 --title "Maintenance d'Ubuntu" --text "Voulez-vous supprimer les fichiers de la corbeille antérieurs au <b>$TRASH</b> ?"
    if [ $? == 0 ]
	then
	    trash-empty 21
	fi
    notify-send -i dialog-ok "Maintenance d'Ubuntu" "Terminée avec succès"

else
    notify-send -i dialog-close "Maintenance d'Ubuntu" "Annulé"
    exit
fi
