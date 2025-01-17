getnum() {
        case $1 in
        "0") local reg="000" ;;
        "1") local reg="001" ;;
        "2") local reg="010" ;;
        "3") local reg="011" ;;
        "4") local reg="100" ;;
        "5") local reg="101" ;;
        "6") local reg="110" ;;
        "7") local reg="111" ;;
	*)   printf "Ошибка: цифра $1 на строке $(( $i + 1 )) не найдена\n" > /dev/stderr && exit 127
        esac

        echo "$reg"
}

getreg() {
	case $1 in
	"B") local reg="000" ;;
        "C") local reg="001" ;;
        "D") local reg="010" ;;
        "E") local reg="011" ;;
        "H") local reg="100" ;;
        "L") local reg="101" ;;
        "M") local reg="110" ;;
        "A") local reg="111" ;;
	*)   printf "Ошибка: регистр $1 на строке $(( $i + 1 )) не найден\n" > /dev/stderr && exit 127
        esac

	echo "$reg"
}

getregspec() {
	case $1 in
	"B")   local reg="00" ;;
	"D")   local reg="01" ;;
	"H")   local reg="10" ;;
	"SP")  local reg="11" ;;
	"PSW") local reg="11" ;;
	*)     printf "Ошибка: регистр $1 на строке $(( $i + 1 )) не найден\n" > /dev/stderr && exit 127
	esac

	echo "$reg"
}

getregopt() {
	local opt=$(echo ${FILEASM[i]} | cut -d' ' -f2 | cut -d',' -f1)

	printf "`getreg "$opt"`"
}

getregoptspec() {
	case $1 in
	"false") local opt=$(echo ${FILEASM[i]} | cut -d' ' -f2 | cut -d',' -f1) ;;
	"true") local opt=$(echo ${FILEASM[i]} | cut -d' ' -f2 | cut -d' ' -f2) ;;
	esac

        printf "`getregspec "$opt"`"
}

getregopts() {
	local optone=$(echo ${FILEASM[i]} | cut -d' ' -f2 | cut -d',' -f1)
	local opttwo=$(echo ${FILEASM[i]} | cut -d' ' -f2 | cut -d',' -f2)

	printf "`getreg "$optone"``getreg "$opttwo"`"
}

getnumopt() {
        local opt=$(echo ${FILEASM[i]} | cut -d' ' -f2)

        printf "`getnum "$opt"`"
}

readdata16bit() {
	local opttwo=$(echo ${FILEASM[i]} | cut -d' ' -f2 | cut -d'x' -f2)
	printf "$(echo $opttwo | cut -c 3-4)$(echo $opttwo | cut -c 1-2)"
}

readdata8bit() {
	local opttwo=$(echo ${FILEASM[i]} | cut -d' ' -f2 | cut -d'x' -f2)
	printf "$opttwo"
}
