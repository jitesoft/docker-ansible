FROM alpine:3.8
LABEL maintainer="Johannes Tegnér <johannes@jitesoft.com>"
RUN apk add --no-cache ansible
ENTRYPOINT [ "ansible" ]
CMD [ "--version" ]
