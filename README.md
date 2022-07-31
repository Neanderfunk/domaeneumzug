# Umzug von Routern aus der Domäne 11_lvr in die ausgewählte extra Domäne



Die umzuziehenden Router müssen in die hostsraw.csv

Format:
`Domain,Domäne,MAC,NodeID,Standort,IPv6`

Wichtig sind die Spalten: **Domäne**, **NodeID** und **IPv6**

Die Spalte Domäne beinhaltet die neue Zieldomäne mit oder ohne Unterstrich. Sollte er fehlen wird er nachgetragen.
Dabei entsteht die **hosts.csv**


Führe nun die `cleancsv.sh` aus um die **hosts.csv** zu erzeugen.
```bash
./cleancsv.sh
```

Danach führe folgenden Befehl aus, dabei entsteht die **hosts.yml**

```bash
ansible-playbook iterate_csv.yml
```


Anschließend kontolliere in der **routerdomaenechange.yml** folgende Parameter:

*domaenevorher* gibt die Domäne an in der die Router aktuell sind.
*update_fwserver* gibt mit **yes** an, dass die Firmwareupdate Server Liste aktualisiert werden soll. Bei **no** werden diese nicht aktualisiert.
*force_update* gibt mit **yes** an, dass auf dem Router `autoupdater -f --force-version` ausgeführt wird am Ende. Bei **no** wird kein `autoupdater` ausgeführt.

Sollten die Parameter passen, dann führe folgenden Befehl aus:
**Achte darauf die keyfile Angabe an dein System anzupassen. Es muss der passende private key angegeben werden, der auf den Routern hinterlegt ist.**

```bash
ansible-playbook -i hosts.yml routerdomaenechange.yml --key-file "~/.ssh/id_rsa"
```
