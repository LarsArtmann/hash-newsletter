#!/usr/bin/env bash

# Import credentials form config file
. ./credentials.config

SITES=(
	"kotlin-updates:https://blog.jetbrains.com/kotlin/category/releases/"
)

for entry in "${SITES[@]}" ; do
    FILE=${entry%%:*}
    CHECK_URL=${entry#*:}
	. ./hashs.sh $CHECK_URL $FILE

	URL="https://api.telegram.org/bot${KEY}/sendMessage"
	TEXT="The hash of [${CHECK_URL}](${CHECK_URL}) has changed from \"$LASTHASH\" to \"$HASH\"!"

	if [ "$LASTHASH" != "$HASH" ]; then
		for i in "${USERID[@]}"
		do
			curl -s -d "chat_id=$i&text=${TEXT}&disable_web_page_preview=true&parse_mode=markdown" $URL > /dev/null
		done
	fi
done
