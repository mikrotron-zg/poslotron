if [ -z "$1" ]
then
	echo "USAGE: ./prodimagesync.sh <source> [dest]"
	echo "i.e. ./prodimagesync.sh ofbiz@ofbiz.org:/opt/ofbiz /opt/ofbiz"
	echo "rsync product images from <source> to local project tree"
	exit 1
fi

SOURCE=$1

if [ -z "$2" ]
then
	DEST=.
else
	DEST=$2
fi

rsync -zvr $SOURCE/framework/images/webapp/images/products/ $DEST/framework/images/webapp/images/products/
