FROM alpine:3
RUN apk add himalaya jq pup envsubst
ADD config.toml /root/.config/himalaya/
ADD start.sh /
ADD process_mail.sh /
ENTRYPOINT [ "sh", "/start.sh" ]