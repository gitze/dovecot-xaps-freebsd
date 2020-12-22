#!/bin/bash
# using read command without any variable
# change to "read -sp" if password input should be hidden
configfile="$1"
[[ "$configfile" == "" ]] && configfile="xapsd.yaml" && echo "please pass $configfile as first paramater." 
echo "Using config file: ./$configfile"

read -p 'Username: ' uservar
read -p 'Password: ' passvar 
[[ "$uservar" == "" ]] && echo "No username set. Exiting script" && exit 1
[[ "$passvar" == "" ]] && echo "No password set. Exiting script" && exit 1
hashvalue=`echo -n "$passvar" | openssl dgst -sha256 -binary | xxd -p -c 32`

sed -E -i .bak "s/^(appleId[[:blank:]]*[=|:][[:blank:]]*).*/\1$uservar/" "$configfile"
sed -E -i .bak "s/^(appleIdHashedPassword[[:blank:]]*[=|:][[:blank:]]*).*/\1$hashvalue/" "$configfile"

echo
echo "Seting new parameter in $configfile"
echo "appleId: $uservar"
echo "appleIdHashedPassword: $hashvalue"