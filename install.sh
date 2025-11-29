#!/usr/bin/bash

if [ ! -d $HOME/.local/bin/ ]; then
    mkdir -p $HOME/.local/bin/ || {
        echo "Error: Could not create directory: $OUTPUT_DIR"
        exit 1
    }
fi

cp ./ytdownload.sh $HOME/.local/bin/ytdownload
echo "ytdownload copied to ~/.local/bin/"

