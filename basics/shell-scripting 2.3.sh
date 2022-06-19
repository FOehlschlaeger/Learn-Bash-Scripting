
#-------------------------------------------------------------------
#            Shell Scripting Teil 2.3.
#-------------------------------------------------------------------


echo "--- 6 ---Funktionen"


# eine Funktion aufgerufen
function funktions_name () {

	echo "ich werden aus der Funktion aufgerufen!"
	read -p "continue with return"
}

funktions_name


# Parameter einer Funktion übergeben
function parameter_uebergeben () {

	echo "ich werden aus der Funktion aufgerufen und habe auch den Parameter: ${1}"
	read -p "continue with return"
	
}

parameter_uebergeben "Hallo Welt"



# Verzeichnisparameter definieren
# Verzeichnis ausgabe erstellen

target=~/ausgabe

# Parameter und Verzeichnis übergeben
function dateiname_setzen () {
	date | tee --append "${target}/${1}"
  	read -p "continue with return"
}

dateiname_setzen "myfile_2.txt"


# mehrere Parameter und Verzeichnis übergeben
function parameter_dateiname_setzen () {

	${2} | tee -a "${target}/${1}"
	read -p "continue with return"

}

parameter_dateiname_setzen "mytext_3.txt" "whoami"

#-------------------------------------------------------------------
