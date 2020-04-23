# linux-maintenance
<p>Un script shell qui permet de faire une maintenance complète du système linux (sous Ubuntu). 
Les paquets utiles seront installés automatiquement s'ils ne le sont pas.</p>

<p>La partie nettoyage de la corbeille permet de supprimer (ou non) les fichiers présents dans la corbeille depuis plus de 2 semaines. Mais vous pouvez changer cette valeur avec la macro correspondante. Explications ici : <a href="https://linuxhandbook.com/date-command/" title="commande date">https://linuxhandbook.com/date-command/</a>

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
