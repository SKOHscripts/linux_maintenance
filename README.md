# linux-maintenance

![Creative Commons](cc.png)
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

<p>Un script shell qui permet de faire une maintenance complète du système Linux (sous Ubuntu). 
Les paquets utiles seront installés automatiquement s'ils ne le sont pas.</p>

<p>La partie nettoyage de la corbeille permet de supprimer (ou non) les fichiers présents dans la corbeille depuis plus de 1 semaine. Mais vous pouvez changer cette valeur avec la macro correspondante. Explications ici : <a href="https://linuxhandbook.com/date-command/" title="commande date">https://linuxhandbook.com/date-command/</a>

Pour lancer le script, ne pas oublier d'autoriser l'exécution : <br/>`chmod +x ./maintenance.sh`

Puis se placer dans le dossier et exécuter le script : <br/>`./maintenance.sh`

Et voilà, après tout se fait tout seul :
<b><ol>
    <li>Mise à jour</li>
    <li>Autoremove/clean</li>
    <li>"Localepurge" des fichiers inutiles en fonction de votre langue</li>
    <li>Purge des paquets supprimés</li>
    <li>Purge des kernels inutiles et mis en "manuels"</li>
    <li>Mise à jour des snaps</li>
    <li>Résolution des dépendances non présentes</li>
    <li>Nettoyage de la corbeille</li>
</ol>
</b>

---

<p>A shell script that allows to do a complete maintenance of the Linux system (under Ubuntu). Useful packages will be installed automatically if they are not.</p>

<p>The "trash cleanup" part allows to remove (or not) files that have been in the trash for more than 1 week. But you can change this value with the corresponding macro. Explanations here: <a href="https://linuxhandbook.com/date-command/" title="commande date">https://linuxhandbook.com/date-command/</a>

To launch the script, don't forget to allow the execution : <br/> chmod +x ./maintenance.sh

Then go into the folder and execute the script : <br/> ./maintenance.sh

And voilà, everything is done by itself:
<b><ol>
    <li>Updating</li>
    <li>Autoremove/clean</li>
    <li>"Localepurge" junk files according to your language</li>
    <li>Purging deleted packages</li>
    <li>Purge useless kernels and put them in "manuals".</li>
    <li>Snapshot update</li>
    <li>Resolution of dependencies not present</li>
    <li>Cleaning the basket</li>
</ol>
</b>
