#! /bin/bash

# Get line with format "NAME=*"
DISTR_LINE=$(cat /etc/*-release | grep -E "^NAME=")

# Remove the preceding 'NAME=' proportion
DISTR_SPLIT=(${DISTR_LINE//=/ })
DISTR_SPLIT=${DISTR_SPLIT[1]}

# Sanitize any quotes or any other illegal characters
DISTR=(${DISTR_SPLIT//\"/})

# Check if 'makefile.config.$DISTR' exists
if [ -f "makefile.config.$DISTR" ]; then
	echo -e "\e[0;32m[guess.sh]\e[0;37m Set platform to $DISTR"
	PLAT=$DISTR
else
	echo -e "\e[1;33m[Warning]\e[0;37m Compiling on distro $DISTR, which has no associated configuration."
	PLAT=generic
fi

# Now setup enviromnent
cp makefile.config.$PLAT ../../Source/makefile.config
