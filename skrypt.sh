#!/bin/bash

function display_help {
    echo "Użycie: projekt.sh [opcja]"
    echo "Opcje:"
    echo "  --date, -d     Wyświetla dzisiejszą datę"
    echo "  --logs, -l     Tworzy automatycznie 100 plików logx.txt"
    echo "  --logs <n>     Tworzy automatycznie <n> plików logx.txt"
    echo "  --help, -h     Wyświetla pomoc"
    echo "  --init, -i     Klonuje całe repozytorium do katalogu w którym został uruchomiony oraz ustawia ścieżkę w zmiennej środowiskowej PATH"
    echo "  --error <n>, -e <n>     Tworzy automatycznie <n> plików errorx.txt"
}

function create_gitignore {
    echo "*log*" > .gitignore
}

function create_logs {
    local num_files=${1:-100} 
    local script_name=$(basename "$0")
    local date=$(date +"%Y-%m-%d")

    for ((i=1; i<=$num_files; i++)); do
        echo "Nazwa pliku: log$i.txt" > "log$i.txt"
        echo "Nazwa skryptu: $script_name" >> "log$i.txt"
        echo "Data: $date" >> "log$i.txt"
    done
}


function create_errors {
    local num_files=${1:-100} 
    local script_name=$(basename "$0")

    for ((i=1; i<=$num_files; i++)); do
        echo "Błąd numer $i" > "error$i.txt"
        echo "Nazwa skryptu: $script_name" >> "error$i.txt"
        echo "Data: $(date +"%Y-%m-%d")" >> "error$i.txt"
    done
}

case "$1" in
    --date|-d)
        date
        ;;
    --logs|-l)
        if [ -z "$2" ]; then
            create_logs
        else
            if [[ $2 =~ ^[0-9]+$ ]]; then
                create_logs "$2"
            else
                echo "Błąd: Argument musi być liczbą całkowitą."
            fi
        fi
        ;;
    --help|-h)
        display_help
        ;;
    --init|-i)
        git clone <adres_repozytorium> .
        export PATH=$PATH:$(pwd)
        ;;
    --error|-e)
        if [ -z "$2" ]; then
            create_errors
        else
            if [[ $2 =~ ^[0-9]+$ ]]; then
                create_errors "$2"
            else
                echo "Błąd: Argument musi być liczbą całkowitą."
            fi
        fi
        ;;
    *)
        echo "Błąd: Nieznana opcja."
        display_help
        exit 1
        ;;
esac

create_gitignore


