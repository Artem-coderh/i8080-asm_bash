if [[ $1 == "" ]]; then
	echo "Ошибка: входной файл не указан"
	exit
fi

if [[ $1 == "--help" ]]; then
        echo "./i8080asm.sh [Входной файл] [Выходной файл(необязательно)]"
	exit
fi

if [[ $2 != "" ]]; then
        OUT=$2
else
        OUT=a.out
fi

if [[ -e $1 ]]; then
	./asmpreproc.sh $1 | ./asmproc.sh /dev/stdin | xxd -r -p > $OUT
else
	echo "Ошибка: входного файла не существует"
	exit
fi
