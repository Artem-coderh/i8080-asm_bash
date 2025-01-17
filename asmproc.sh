source func.sh
readarray FILEASM < $1
arraysize=$(( ${#FILEASM[@]} - 1 ))

for i in $(seq 0 $arraysize); do
	INS=$(echo ${FILEASM[i]} | cut -c1-4 | sed 's/ //g')
	case $INS in
	"MOV")  printf "%x" $((2#01`getregopts`)) ;;
	"MVI")  printf "%02x" $((2#00`getregopt`110)) && printf `readdata8bit` ;;
	"JMP")  printf "c3" && printf `readdata16bit` ;;
	"NOP")  printf "00" ;;
	"LXI")  printf "%02x" $((2#00`getregoptspec "false"`0001)) && printf `readdata16bit`;;
	"STAX") printf "%02x" $((2#00`getregoptspec "true"`0010)) ;;
	"IN")   printf "db" && printf `readdata8bit` ;;
	"RST")  printf "%02x" $((2#11`getnumopt`111)) ;;
	"CALL") printf "cd" && printf `readdata16bit` ;;
	"CC")   printf "dc" && printf `readdata16bit` ;;
	"CNC")  printf "d4" && printf `readdata16bit` ;;
	"CZ")   printf "cc" && printf `readdata16bit` ;;
	"CNZ")  printf "c4" && printf `readdata16bit` ;;
	"CP")   printf "f4" && printf `readdata16bit` ;;
	"CM")   printf "fc" && printf `readdata16bit` ;;
	"CPE")  printf "ec" && printf `readdata16bit` ;;
	"CPO")  printf "e4" && printf `readdata16bit` ;;
	"RET")  printf "c9" ;;
	"RC")   printf "d8" ;;
	"RNC")  printf "d0" ;;
	"RZ")   printf "c8" ;;
	"RNZ")  printf "c0" ;;
	"RP")   printf "f0" ;;
	"RM")   printf "f8" ;;
	"RPE")  printf "e8" ;;
	"RPO")  printf "e0" ;;
	"PUSH") printf "%02x" $((2#11`getregoptspec "true"`0101)) ;;
	"POP")  printf "%02x" $((2#11`getregoptspec "true"`0001)) ;;
	"STA")  printf "32" && printf `readdata16bit` ;;
	"LDA")  printf "3a" && printf `readdata16bit` ;;
	"XCHG") printf "eb" ;;
	"XTHL") printf "e3" ;;
	"PCHL") printf "e9" ;;
	"DAD")  printf "%02x" $((2#00`getregoptspec "true"1001`)) ;;
	"LDAX") printf "%02x" $((2#00`getregoptspec "true"`1010)) ;;
	"INX")  printf "%02x" $((2#00`getregoptspec "true"`0011)) ;;
	"HLT")  printf "76" ;;
	"OUT")  printf "d3" && printf `readdata8bit` ;;
	"INR")  printf "%02x" $((2#00`getregopt`100)) ;;
	"DCR")  printf "%02x" $((2#00`getregopt`101)) ;;
	"ADD")  printf "%02x" $((2#10000`getregopt`)) ;;
	"ADC")  printf "%02x" $((2#10001`getregopt`)) ;;
	"SUB")  printf "%02x" $((2#10010`getregopt`)) ;;
	"SBB")  printf "%02x" $((2#10011`getregopt`)) ;;
	"AND")  printf "%02x" $((2#10100`getregopt`)) ;;
	"XRA")  printf "%02x" $((2#10101`getregopt`)) ;;
	"ORA")  printf "%02x" $((2#10110`getregopt`)) ;;
	"CMP")  printf "%02x" $((2#10111`getregopt`)) ;;
	"ADI")  printf "c6" && printf `readdata8bit` ;;
	"ACI")  printf "ce" && printf `readdata8bit` ;;
	"SUI")  printf "d6" && printf `readdata8bit` ;;
	"SBI")  printf "de" && printf `readdata8bit` ;;
	"ANI")  printf "e6" && printf `readdata8bit` ;;
	"XRI")  printf "ee" && printf `readdata8bit` ;;
	"ORI")  printf "f6" && printf `readdata8bit` ;;
	"CPI")  printf "fe" && printf `readdata8bit` ;;
	"RLC")  printf "07" ;;
	"RRC")  printf "0f" ;;
	"RAL")  printf "17" ;;
	"RAR")  printf "1f" ;;
	"JC")   printf "da" && printf `readdata16bit` ;;
	"JNC")  printf "d2" && printf `readdata16bit` ;;
	"JZ")   printf "ca" && printf `readdata16bit` ;;
	"JNZ")  printf "c2" && printf `readdata16bit` ;;
	"JP")   printf "f2" && printf `readdata16bit` ;;
	"JM")   printf "fa" && printf `readdata16bit` ;;
	"JPE")  printf "ea" && printf `readdata16bit` ;;
	"JPO")  printf "e2" && printf `readdata16bit` ;;
	"DCX")  printf "%02x" $((2#00`getregoptspec "true"`1011)) ;;
	"CMA")  printf "2f" ;;
	"STC")  printf "37" ;;
	"CMC")  printf "3f" ;;
	"DAA")  printf "27" ;;
	"SHLD") printf "22" && printf `readdata16bit`;;
	"LHLD") printf "2a" && printf `readdata16bit`;;
	"EI")   printf "fb" ;;
	"DI")   printf "f3" ;;

	"")     ;;
	*)      printf "Ошибка: инструкциия "${INS}" на строке $(( $i + 1 )) не найдена!\n" > /dev/stderr && exit 127 ;;
	esac
done
