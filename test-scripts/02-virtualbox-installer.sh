#!/bin/bash

#===============================================================================
#
# Skriptname: virtualbox-installer
# Autor:      Friso Oehlschlaeger
# Version:    0.1 (Beta)
#
# USAGE:      sudo ./virtualbox-installer
#               oder
#             sudo bash virtualbox-installer
# 
#             (Attention: Do NOT execute as "root" user!)
# 
# DESCRIPTION: Shell script to install Oracle virtualbox and Extensions Pack
#              on Debian automatically.
# 
# DEPENCENDIES: Debain GNU/Linux 11
# 
# IMPORTANT REMARK: Read and acknowledge EULA of Oracle. 
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
#===============================================================================

#-------------------------------------------------------------------------------
# Only root should be able to install software!
#-------------------------------------------------------------------------------
if ! [ "$( id --user )" -eq 0 ] ; then
  echo "Please execute using sudo!"
  exit 1
fi
# TODO: User must not be root user

#-------------------------------------------------------------------------------
# Add the repository from virtualbox.org
#-------------------------------------------------------------------------------

readonly CODENAME=$( lsb_release -cs )
apt install apt-transport-https --assume-yes
echo "deb https://download.virtualbox.org/virtualbox/debian ${CODENAME} \
  contrib" > /etc/apt/sources.list.d/virtualbox.list

#-------------------------------------------------------------------------------
# Add the GPG key for virtualbox.org
#-------------------------------------------------------------------------------

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O \
  /etc/apt/trusted.gpg.d/oracle_vbox_2016.asc

#-------------------------------------------------------------------------------
# Update the list of available packages from the apt sources,
#   do an full-upgrade and some "housekeeping".
#-------------------------------------------------------------------------------

apt update \
  && apt full-upgrade --assume-yes \
  && apt --fix-broken-install --assume-yes \
  && apt-autoremove --assume-yes \
  && apt-autoclean --assume-yes

#-------------------------------------------------------------------------------
# Install virtualbox latest version of virtualbox.
#-------------------------------------------------------------------------------

readonly VIRTUALBOX_VERSION=\
  "$(apt-cache search --names-only "^virtualbox-[[:digit:]]" \
  | tail -n 1 \
  | cut -d " " -f 1)"
apt install "${VIRTUALBOX_VERSION}" --assume-yes

#-------------------------------------------------------------------------------
# Install/replace latest version of virtualbox extension pack.
#-------------------------------------------------------------------------------
readonly VERSION="$( vboxmanage --version )"
readonly LEFT="${VERSION%r*}"
#readonly RIGHT"${VERSION#*r}"

# TODO: create only if not existing
mkdir /root/Downloads
cd /root/Downloads
wget "https://download.virtualbox.org/virtualbox/${LEFT}/\
  Oracle_VM_VirtualBox_Extension_Pack-${LEFT}.vbox-extpack"

#-------------------------------------------------------------------------------
# Add current user to group "vboxusers".
#-------------------------------------------------------------------------------

usermod -aG vboxusers "${SUDO_USER}"

#-------------------------------------------------------------------------------
# Give hint for a "relog".
#-------------------------------------------------------------------------------

echo "Please log off, and log in again after a few minutes."
echo "done."

#-------------------------------------------------------------------------------
# Wait for some user interaction.
#-------------------------------------------------------------------------------

echo "Make program executable after closing using: 'chmod +x'"
read -p "Please press 'Return' to exit program."

exit 0