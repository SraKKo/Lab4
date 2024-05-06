#!/bin/bash

# Funkcja wyświetlająca pomoc
function display_help {
    echo "Użycie: skrypt.sh [opcja]"
    echo "Opcje:"
    echo "  --date         Wyświetla dzisiejszą datę"
    echo "  --logs         Tworzy automatycznie 100 plików logx.txt"
    echo "  --logs <n>     Tworzy automatycznie <n> plików logx.txt"
    echo "  --help         Wyświetla pomoc"
}

# Funkcja tworząca plik .gitignore ignorujący pliki z ciągiem "log"
function create_gitignore {
    echo "*log*" > .gitignore
}

# Funkcja tworząca pliki log
function create_logs {
    local num_files=${1:-100}  # Domyślnie 100 plików, lub wartość przekazana jako argument
    local script_name=$(basename "$0")
    local date=$(date +"%Y-%m-%d")

    for ((i=1; i<=$num_files; i++)); do
        echo "Nazwa pliku: log$i.txt" > "log$i.txt"
        echo "Nazwa skryptu: $script_name" >> "log$i.txt"
        echo "Data: $date" >> "log$i.txt"
    done
}

# Obsługa argumentów
case "$1" in
    --date)
        date
        ;;
    --logs)
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
    --help)
        display_help
        ;;
    *)
        echo "Błąd: Nieznana opcja."
        display_help
        exit 1
        ;;
esac

# Utworzenie pliku .gitignore
create_gitignore

# Zmergowanie zmian do gałęzi głównej i utworzenie tagu v1.0
git add .
git commit -m "Automatyczne zapisywanie zmian przez skrypt"
git checkout master
git merge taskBranch
git tag v1.0
