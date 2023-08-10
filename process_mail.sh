IFS=$'\n'
ID=$1
PAGE_URL=$(himalaya read $ID | grep 'https://.*download\?' | awk '{$1=$1};1')
for item in $(wget -qO - "$PAGE_URL" | pup '#pagedata attr{data-blob}' --plain | jq -rc '.digital_items | .[]')
do
    {
        ARTIST=$(echo $item | jq -r '.artist')
        TITLE=$(echo $item | jq -r '.title')
        URL=$(echo $item | jq -r '.downloads.flac.url')
        OUT_DIR="/output/$ARTIST/$TITLE"
        mkdir -p "$OUT_DIR"
        wget -qO - "$URL" | unzip -d "$OUT_DIR" -
    } || himalaya flags add $ID -- flagged
done
unset IFS