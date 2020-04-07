#!/bin/sh

clear
echo "\t\033[1;33mSCRIPT DE MAINTENANCE D'UBUNTU\n\033[0m"
echo "Maintenance complète\t\033[1;32m(1)\033[0m"
echo "Mises à jour\t\t\033[1;32m(2)\033[0m"
echo ""

while read choix
do
    clear
    echo "\t\033[1;33mSCRIPT DE MAINTENANCE D'UBUNTU\n\033[0m"
    echo "Maintenance complète\t\033[1;32m(1)\033[0m"
    echo "Mises à jour\t\t\033[1;32m(2)\033[0m"
    echo ""

	case $choix in
		1)  echo "\033[1;32m===MISE A JOUR===\033[0m"
		    sudo dpkg --configure -a
		    sudo apt update
		    sudo apt full-upgrade
		    echo " "
		    echo "\033[1;32m===AUTO-REMOVE===\033[0m"
		    sudo apt autoremove
		    echo " "
		    echo "\033[1;32m===CLEAN===\033[0m"
		    sudo apt autoclean
		    echo " "
		    echo "\033[1;32m===LOCALE-PURGE===\033[0m"
		    sudo localepurge
		    echo "\033[1;32m===PURGE===\033[0m"
		    sudo apt purge $(COLUMNS=200 dpkg -l | grep "^rc" | tr -s ' ' | cut -d ' ' -f 2)
		    echo " "
		    echo "\033[1;32m===NETTOYAGE DES SNAPS===\033[0m"
		    sudo snap refresh
		    sudo apt clean && snap list --all | awk 'BEGIN {print "#! /bin/sh\n"} ; /désactivé|disabled/ {print "snap remove "$1" --revision "$3"\n"} ; END {print "exit 0"}' > script && chmod +x script && ./script && rm script && echo && snap list --all && echo && df -Th | grep -Ev "tmpfs|squashfs"
		    echo "" 
		    echo "\033[1;32m===apt-get install -f===\033[0m"
		    sudo apt install -f
		    echo ""
		    echo "\033[1;32m===CORBEILLE===\033[0m"
		    echo ""
		    trash-list
		    echo ""
		    echo -n "\033[1;33mSupprimer définitivement les fichiers vieux de plus de (jours): "
		    read trash
		    trash-empty $trash
		    echo "\033[0m"
		    echo -n "\033[1;33m\tNETTOYAGE TERMINE\n\033[0m"
		    echo ""
		    exit 0;;
        	2)  echo "\033[1;32m===VERIFICATION DES MISES A JOUR===\033[0m"
		    sudo apt update
		    echo ""
            	exit 0;;
	esac
done
