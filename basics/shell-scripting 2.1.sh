#!/bin/bash


# ------------------------------------------------
# Shell-Script 2.1
# ------------------------------------------------



# Kommentar


# sudo apt update
# sudo apt upgrade
clear

# ------------------------------------------------

# Ausgabe auf der Konsole


echo "--- 1 --- Ausgabe ---"

echo Hallo Welt!


echo "Hallo        Welt     !!!!"
echo "Ausgabe über \"diese Zeile\"
und auf eine weitere Zeile"

# Fehlerbehandlung

# "--- 1.2 --- Fehler---"

# exit 0 Erfolgreich
# exit 1 Fehler - o -255

echo "das Programm wurde folgendermaßen durchlaufen: " $?
echo "die Datei lautet: " $0



# --------------------------------------------------

# Variablen

echo "--- 2.1 --- Variablen"


message="Hallo Welt"

echo "$message"
echo "Satzeil davor" $message "und dahinter"
echo "in einen String die Variable ${message} eingefügt!"


echo "--- 2.2 --- Umgebungsvarialben"

# User - $USER
# Home - $HOME
# pwd  - $PWD
# aktuelle Verzeichnis - $PATH

echo "Home: " $HOME
echo "aktuelles Verzeichnis:" $PATH
echo "pwd: " $PWD


echo "--- 2.3 --- dynamische Varialbe"

echo $(date)
echo "heute ist: " $(date "+%d.%m.%Y")

echo "--- 2.4 --- Konstante"


message="aus Hallo Welt wird nun dies"
echo $message

readonly PI="3,1415"
PI="0"
echo "die Konstante PI ${PI} konnte nicht geändert werden!"


# ----------------------------------------------------------

echo "--- 3 --- Eingabe über die Konsole"

read -p "Wie ist dein Name? " name
echo "Hallo " $name

echo $?


# ----------------------------------------------------------

echo "--- 4 --- Umleitungen"

# > Umleitung von Standardausgabe in eine Datei
# >> anhängen der Standardausgabe in die Datei
# < wird aus der Datei gelesen
# |  die Ausgabe des Kommandos wird für eine andere verwendet

echo "heute ist: " $(date) >> datum.txt

sort < datum.txt



# Kanal 1	(stdout) 	Standardausgabe von Befehl in Datei / anhängen
# Kanal 2	(stderr)	Standardfehlerausgabe von Befehlen in Datei

# Kanal 1 & 2   (out/err)

# die Syntax 2>&1 leitet auf beide Kanäle aus

date 2>&1
date 2>&1 | tee datum.txt  # nur einmal
date 2>&1 | tee -a datum.txt  # anhängen

