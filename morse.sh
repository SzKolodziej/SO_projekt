#!/bin/bash

alph=(.- -... -.-. -.. . ..-. --. .... .. .--- -.- .-.. -- -. --- .--. --.- .-. ... - ..- ...- .-- -..- -.-- --..)
num=(----- .---- ..--- ...-- ....- ..... -.... --... ---.. ----.)

result=()

read str

for ((i = 0; i < ${#str}; i++))
do
	char=$(printf '%d' "'${str:i:1}")

	if [[ $char -ge 65 ]] && [[ $char -le 90 ]]; then
		#echo -n "${alph[$(($char % 65))]}"
		result+="${alph[$(($char % 65))]} "
	elif [[ $char -ge 97 ]] && [[ $char -le 122 ]]; then
		#echo -n "${alph[$(($char % 97))]}"
		result+="${alph[$(($char % 97))]} "
	elif [[ $char -ge 48 ]] &&  [[ $char -le 57 ]]; then
		#echo -n "${num[$(($char % 48))]}"
		result+="${num[$(($char % 48))]} "
	elif [[ $char == 32 ]]; then
		#echo -n " "
		result+="/ "
	else
		echo "Invalid symbol"
		break
	fi
done

echo ""

echo $result
