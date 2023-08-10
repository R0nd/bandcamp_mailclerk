cat /root/.config/himalaya/config.toml | envsubst '$EMAIL,$IMAP_HOST,$QUERY' > /root/.config/himalaya/config.toml
for id in $(himalaya search "$QUERY" -o json | jq -r '.[] | .id')
do
    /process_mail.sh $id
done
himalaya notify