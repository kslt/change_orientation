#!/bin/bash

FILE="/home/tekniker/scripts/start_gui"
SEARCH="DISPLAY_ORIENTATION=normal"
REPLACE="DISPLAY_ORIENTATION=left"

# Kontrollera om filen finns
if [ ! -f "$FILE" ]; then
    echo "Filen $FILE finns inte."
    exit 1
fi

# Kontrollera om raden finns
if grep -q "$SEARCH" "$FILE"; then
    echo "Följande rad hittades:"
    grep "$SEARCH" "$FILE"

    echo "Vill du ändra denna rad till:"
    echo "$REPLACE"
    read -p "Skriv 'ja' för att bekräfta ändringen: " confirm

    if [ "$confirm" = "ja" ]; then
        # Gör backup först
        cp "$FILE" "$FILE.bak"
        sed -i "s|$SEARCH|$REPLACE|" "$FILE"
        echo "Ändringen är gjord. Backup sparad som $FILE.bak"

        # Fråga om reboot
        read -p "Vill du starta om datorn nu? (ja/nej): " reboot_confirm
        if [ "$reboot_confirm" = "ja" ]; then
            echo "Startar om..."
            sudo reboot
        else
            echo "Ingen omstart gjordes."
        fi
    else
        echo "Ingen ändring gjordes."
    fi
else
    echo "Raden '$SEARCH' hittades inte i filen."
fi
