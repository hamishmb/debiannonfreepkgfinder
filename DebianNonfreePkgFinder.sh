#!/bin/bash
# Copyright (C) 2019-2022 Hamish McIntyre-Bhatty
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License version 3 or,
# at your option, any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#DebianNonfreePkgFinder Version 1.0.

#This program is written for Debian, and will need tweaking to work on Ubuntu as the repository
#names are different.

#The names of all contrib and non-free packages are listed.
#contrib packages are shown in yellow, and non-free packages are shown in red.

#This script supplements vrms for me when building a live CD/DVD/USB for distribution, as it
#performs some extra checks and also lists the source repositories too. Hopefully it can be
#of use to other people too.

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

for pkg in $(dpkg --get-selections)
do
    component=$(apt-cache policy $pkg | grep "http" | awk '{print $3}')
    component=$(echo $component | awk '{print $0}')

    if [[ $component == *"contrib" ]]
    then
        echo -e "${GREEN}$pkg:${NC} ${YELLOW}$component${NC}"
    
    fi

    if [[ $component == *"non-free" ]]
    then
        echo -e "${GREEN}$pkg:${NC} ${RED}$component${NC}"

    fi
done
