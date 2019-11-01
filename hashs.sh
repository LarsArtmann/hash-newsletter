CHECK_URL=$1
DIR="hashs/"
FILE=$DIR$2".hash"

mkdir -p $DIR

LASTHASH=$(tail -1 ${FILE})
HASH=$(curl -s ${CHECK_URL} | sha256sum | awk '{print $1}')

echo $(curl -s ${CHECK_URL})
echo $(curl -s ${CHECK_URL} | sha256sum)

rm $FILE
echo $HASH >> $FILE