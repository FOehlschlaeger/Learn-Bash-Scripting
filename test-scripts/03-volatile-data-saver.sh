#!/bin/bash

#===============================================================================
#
# DIRECTORY:
#   "root of an external media"
#
# FILE:
#   volatile-data-saver
#
# USAGE:
#   Set "TARGET" and run
#     $ ./volatile_data
#   OR
#     $ /bin/bash volatile_data
#
# OPTIONS:
#   See function ’usage’ below!
#
# DESCRIPTION:
#   Display and redirect volatile data into textfiles.
#
# EXIT STATES:
#   0 = success
#   1 = TARGET not set in script!
#   2 = TARGET is not an external media!
#   ???
#
# REQUIREMENTS:
#   ???
#
# BUGS:
#   ---
#
# NOTES:
#   ---
#
# AUTHOR:
#   ???, me@example.net
#
# COMPANY:
#   ???
#
# VERSION:
#   ??? (devel)
#
# LINK TO THE MOST CURRENT VERSION:
#   ???
#
# CREATED:
#   ???
#
# COPYRIGHT (C):
#   ??? - ???
#
# LICENSE:
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
# WARRANTY:
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# TODO:
#   - ???
#
# HISTORY:
#   1.0 - ??? - ???
#
# THANKS TO:
#   ???
#
#===============================================================================

#=== CONFIGURATION =============================================================
if [ -z "${1}" ] ; then
  if [ "$( id --user )" -eq 0 ] ; then
    readonly TARGET="/media/user02/POLIZEI"
    echo "Default target directory: ${TARGET}"
  else
    readonly TARGET="/media/${USER}/POLIZEI"
    echo "Default target directory: ${TARGET}"
  fi
else
  readonly TARGET="${1}"
  echo "Given target to store files: ${TARGET}"
  echo "Creating target directories..."
  mkdir -p "${1}"
fi
#readonly TARGET="/media/user02/POLIZEI"

export PATH="/sbin:/usr/sbin:/bin:/usr/bin"

#=== FUNCTION ==================================================================
# NAME: usage
# DESCRIPTION: Display usage information for this script.
# PARAMETER 1: ---
#===============================================================================
function usage () {
  echo
  echo "Usage: Connect external media, set \"TARGET\" and run $0"
  echo
}

#=== FUNCTION ==================================================================
# NAME: doit
# DESCRIPTION: macht was
# PARAMETER 1: Befehl (inkl. Optionen, ...)
# PARAMETER 2: Datei
#===============================================================================
function doit () {
  date | tee --append "${TARGET}/${2}"
  echo -e "\n##########\n" | tee --append "${TARGET}/${2}"
  ${1} | tee --append "${TARGET}/${2}"
  read -p "continue with return"
}

#-------------------------------------------------------------------------------
# Please set the per default emtpy Variable "TARGET" before running this script!
#-------------------------------------------------------------------------------
echo "Target is set to: ${TARGET}"

if [ -z "${TARGET}" ] ; then
  usage
  exit 1
fi

#-------------------------------------------------------------------------------
# Check if TARGET is really a mounted filesystem from an external media!
#-------------------------------------------------------------------------------
if ! grep --fixed-strings "${TARGET}" /proc/mounts > /dev/null 2>&1 ; then
  usage
  exit 2
fi

#--- HINT: ---------------------------------------------------------------------
# "history" does not work in this script!
# "history" has to be executed directly in every open terminal/tty!
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# 1. This commands displays neighbour tables (ARP-Cache) and saves it
#-------------------------------------------------------------------------------
doit "ip n" "ip_neighbour_show.txt"

#-------------------------------------------------------------------------------
# 2. Content of the kernel ring buffer
#-------------------------------------------------------------------------------
if [ "$( id --user )" -eq 0 ] ; then
  doit "dmesg" "dmesg.txt"
fi

#-------------------------------------------------------------------------------
# 3. Time and date of the system
#-------------------------------------------------------------------------------

doit "timedatectl" "time-and-date.txt"

#-------------------------------------------------------------------------------
# 4. User- and group-IDs
#-------------------------------------------------------------------------------

doit "id" "user-and-group-ids.txt"

#-------------------------------------------------------------------------------
# 5. Running processes
#-------------------------------------------------------------------------------

doit "ps aux" "processlist.txt"

#-------------------------------------------------------------------------------
# 6. Used mountpoints
#-------------------------------------------------------------------------------

doit "cat /proc/mounts" "mountpoints.txt"

#-------------------------------------------------------------------------------
# 7. IP and/or IPv6 address configuration
#-------------------------------------------------------------------------------

doit "ip a" "ip-address-show.txt"

#-------------------------------------------------------------------------------
# 8. Active TCP-, UPD- and IP-Connections in detail
#-------------------------------------------------------------------------------

if [ "$( id --user )" -eq 0 ] ; then
  doit "ss -natup" "socket-statistics-as-root.txt"
else
  doit "ss -natu" "socket-statistics-as-user.txt"
fi

#-------------------------------------------------------------------------------
# 9. Block devices
#-------------------------------------------------------------------------------

if [ "$( id --user )" -eq 0 ] ; then
  doit "blkid" "blkid.txt"
fi

#-------------------------------------------------------------------------------
# 10. Serial numbers of eg. harddisc(s)
#-------------------------------------------------------------------------------

if [ -x "/sbin/hdparm" ] ; then
  if [ "$( id --user )" -eq 0 ] ; then
    doit "hdparm -I /dev/sd?" "serial-numbers-of-disks.txt"
  fi
fi

echo "done."

exit 0