#!/bin/bash

if [ $EUID -ne 0 ]
then
	echo "You must run dkms-install.sh with superuser priviliges."
	echo "Try: \"sudo ./dkms-install.sh\""
	exit 1
fi

if [ -d "/usr/lib/dkms" ]
then
	echo "dkms appears to be installed."
else
	echo "dkms does not appear to be installed."
	echo "Try: \"sudo apt install dkms\""
	exit 1
fi

DRV_NAME=rtl8812au
DRV_VERSION=5.6.4.2

echo "Copying driver to: /usr/src/${DRV_NAME}-${DRV_VERSION}"
cp -r $(pwd) /usr/src/${DRV_NAME}-${DRV_VERSION}

dkms add -m ${DRV_NAME} -v ${DRV_VERSION}
dkms build -m ${DRV_NAME} -v ${DRV_VERSION}
dkms install -m ${DRV_NAME} -v ${DRV_VERSION}

RESULT=$?

if [ "$RESULT" != "0" ]
then
	echo "An error occurred while running dkms-install.sh."
else
	echo "dkms-install.sh was successful."
fi

exit $RESULT