#!/bin/bash

alph=(.- -... -.-. -.. . ..-. --. .... .. .--- -.- .-.. -- -. --- .--. --.- .-. ... - ..- ...- .-- -..- -.-- --..)
num=(----- .---- ..--- ...-- ....- ..... -.... --... ---.. ----.)

result=()

dot="."
dash="-"

help() {
        echo -e "    ________________ "
        echo -e "   |  Help Section  |\n   |________________|"
        echo -e "\n   Usage: morse [Option (optional)] [Text to translate]"
        echo -e "\n   Options: "
        echo -e "\n\t-h, --help\tdisplay this help section"
        echo -e "\t-d\t\tchanges dot sign (pattern: morse -d=[sign]"
        echo -e "\t-D\t\tchanges dash sign (pattern: morse -D=[sign]"
        echo -e "\t-i\t\tignores signs without it's morse code substitute"
        echo -e "\t  \t\t  and skips them"
        echo -e "\t-I\t\tignores signs without it's morse code substitute"
        echo -e "\t  \t\t  and rewrites them"
        echo -e "   Exit status:\n\t0 if OK,\n\t1 if a problem is encounted"
        exit 0
}

if [[ $# == 0 ]]; then
        help
fi

while [[ $# -gt 0 ]]
do
        case "$1" in
                -h|--help)
                        help
                        ;;
                -d=*)
                        dot="${1#-d=}"
                        shift
                        ;;
                -D=*)
                        dash="${1#-D=}"
                        shift
                        ;;
                -i)
                        ignore="1"
                        shift
                        ;;
                -I)
                        ignore="2"
                        shift
                        ;;
                --)
                        shift
                        break
                        ;;
                -*)
                        echo "Unknown option: $1"
                        exit 1
                        ;;
                *)
                        break
                        ;;
        esac
done

text="$*"

if [[ -z $text ]]; then
        echo "error: text is missing"
        exit 1
fi

for ((i = 0; i < ${#text}; i++))
do
        char=$(printf '%d' "'${text:i:1}")

        if [[ $char -ge 65 ]] && [[ $char -le 90 ]]; then
                result+="${alph[$(($char % 65))]} "
        elif [[ $char -ge 97 ]] && [[ $char -le 122 ]]; then
                result+="${alph[$(($char % 97))]} "
        elif [[ $char -ge 48 ]] &&  [[ $char -le 57 ]]; then
                result+="${num[$(($char % 48))]} "
        elif [[ $char == 32 ]]; then
                #echo -n " "
                result+="/ "
        else
                if [[ $ignore == "2" ]] ; then
                        result+="${text:i:1} "
                elif [[ $ignore == "1" ]] ; then
                        continue
                else
                        result="Invalid symbol"
                        break
                fi
        fi
done

echo $result|tr .- $dot$dash

