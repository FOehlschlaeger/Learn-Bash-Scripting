#-------------------------------------------------------------------
#            Shell Scripting Teil 2.2.
#-------------------------------------------------------------------


echo "--- 4 --- if Bedingungen"

# Test-Kommandos siehe: man test
# -d	Verzeichnis
# -e	Datei existiert
# -f	ist eine reguläre Datei
# -w	Datei existiert und Schreibrechte
# -x	Datei existiert und ausführbar
# -n	der String (z.B. Varialbe) ist nicht leer
# -z	der String (z.B. Varialbe) ist leer

# string1 = string2	wahr, wenn string1 gleich string2 ist

# zahl1 -eq zahl2	wahr, zahl1 gleich zahl2
# zahl1 -lt zahl2	wahr, zahl1 kleine zahl2
# zahl1 -gt zahl2	wahr, zahl1 größer zahl2
# zahl1 -le zahl2	wahr, zahl1 kleiner oder größer zahl2
# zahl1 -ge zahl2	wahr, zahl1 größer oder gleich zahl2
# zahl1 -ne zahl2	wahr, zahl1 nicht gleich zahl2

# ! foo			wahr, wenn foo falsch ist, also Negation


# == prüft, ob beide Objekte auf denselben Speicherort zeigen, während equals wertet den Vergleich von Werten in den Objekten aus

echo "--- 4.1 --- if Bedingung"

man test

if [ 1 = 1 ];
then
	echo "true - 1 ist gleich 1"
fi



echo "--- 4.2 --- if - else Bedingung"

if [ 1 = 2 ]
then
	echo "true - 1 ist gleich 1"
else
	echo "die Bedingung ist nicht wahr"
fi


read -p "wie bist du angemeldet? " antwort
if [ "$antwort" = "root" ]
then
	echo "Hi, Root!"
else
	echo "Hi, User!"
fi


if [ -f ~/test.txt ]
then
	echo "Die Datei existiert"
else
	echo "Die Datei ist leider nicht vorhanden"
	#touch ~/test.txt
fi

if ! [ "$(id -u)" -eq 0 ]
then
	echo "du bist leider nicht root!"
else
	echo "Hallo Gott"
fi
