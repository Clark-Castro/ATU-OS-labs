notify_tel () {
	TOKEN="6949573454:AAG7ZSUl6ICGxddOIrZ_9ihcuIjI1G0HyRw"
	CHAT_ID="$1"
	MESSAGE="$(who)"
	curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$MESSAGE" > /dev/null
}
Help () {
	echo
	echo "This script is a telegram logging notifier for linux servers(PCs)."
	echo
	echo "To use the program, you should first start my bot in telegram."
	echo "Then, execute the script in your shell with your telegram UserID"
	echo "(not confused with UserName) as the first argument. "
	echo
	echo "At first, you'll recieve a message containing logged in users."
	echo "After that, anytime a user logs in or out, you'll recieve another"
	echo "message, containing a new list of logged in users with their data."
	echo
	echo "My bot ID: https://t.me/LoggingNotifierBot"
	echo
}

if [ $1 = "-h" ] || [ $1 = "--help" ] ; then
	Help 
else
	notify_tel $1
	m1=$(md5sum <<<"$(who)")

	while true; do
		
		sleep 1

		m2=$(md5sum <<<"$(who)")

		if [ "$m1" != "$m2" ] ; then
			notify_tel $1
			m1=$m2
		fi
	done
fi
