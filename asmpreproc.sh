readarray FILE < $1
arraysize=${#FILE[@]}
TEXT=$(cat $1 | sed 's%//.*%%g' | sed 's%  .*%%g' | tr '\n' "\01")

for i in $(seq 0 $(( $arraysize - 1 ))); do
	echo ${FILE[$i]} | grep ":" > /dev/null
	if [[ $? == 0 ]]; then
		TEXT=$(echo $TEXT | sed "s%\b$(echo ${FILE[$i]} | sed 's/://g')\b%$(printf "0x%04x\n" $i)%g")
	fi
done

echo $TEXT | tr "\01" "\n" | sed 's/.*:/\x01/g' | tr -d '\01'
