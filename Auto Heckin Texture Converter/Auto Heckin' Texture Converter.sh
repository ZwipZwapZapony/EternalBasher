# This file is part of EternalBasher (https://github.com/leveste/EternalBasher).
# Copyright (C) 2021 leveste and PowerBall253
#
# EternalBasher is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# EternalBasher is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of  
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the  
# GNU General Public License for more details.  
#
# You should have received a copy of the GNU General Public License  
# along with EternalBasher. If not, see <https://www.gnu.org/licenses/>.

#!/usr/bin/env bash


# Check for required tools
file_arr=( "./tools/nvcompress.exe" "./tools/nvtt.dll" "./tools/DivinityMashine.exe" )

for i in "${file_arr[@]}"
do
	if [[ ! -f $i ]]
	then
		echo "'$i' not found! Did you extract everything in the tools folder?"
		exit
	fi
done


# Check for arguments
if [ "$#" -eq 0 ]
then
	printf "\n\nNo arguments found. Please pass the files you wish to convert as arguments, as shown below.\n
	./\"Auto Heckin' Texture Converter.sh\" [texture1] [texture2] [...]\n\n"

	exit
fi

while [ $# -ne 0 ]
do
	echo "Converting '$1'..."

	path=$(readlink -f "$1")
	#use subshell for cd operation
	(
	cd tools
	wine nvcompress.exe -bcla -fast "$path" "${path}.dds" > /dev/null
	)
	wine ./tools/DivinityMashine.exe "${1}.dds" > /dev/null

	# remove file extensions
	filename="${i}"
	filename="${filename%%.*}" > /dev/null

	name="${1}.dds"
	tga_name="${name//dds/tga}"

	mv "$tga_name" "${filename}.tga" > /dev/null
	rm "${1}.dds" > /dev/null

	shift
done