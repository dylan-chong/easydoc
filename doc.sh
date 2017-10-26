#!/bin/bash
set -e

if [ -z "$EASYDOC_DIR" ]; then
    echo "No EASYDOC_DIR variable set"
    exit 4
fi
if [ -z "$2" ]; then
    echo "No filename given"
    exit 5
fi

if [ "$1" == "new" ]; then
    echo 'Creating new document'
    if [ -f "$2" ]; then
        echo "Document $2 already exists"
        exit 1
    fi
    cp "$EASYDOC_DIR/doc-template.md" "$2"
elif [ "$1" == "export" ]; then
    echo 'Exporting document to pdf'

    IN_FILE=$2
    OUT_FILE=$(mktemp)
    mv "$OUT_FILE" "$OUT_FILE.pdf"
    OUT_FILE="$OUT_FILE.pdf"

    pandoc --filter pandoc-citeproc "$IN_FILE" -o "$OUT_FILE"
    open "$OUT_FILE"
    sleep 2
    rm "$OUT_FILE"
else
    echo "Illegal argument given: $1"
    exit 3
fi
