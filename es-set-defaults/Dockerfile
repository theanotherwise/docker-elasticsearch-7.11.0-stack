FROM alpine:3.13.1

COPY ./files/es-set-defaults.sh .

RUN apk add curl bash dos2unix && \
    dos2unix es-set-defaults.sh

CMD ["/bin/sh", "es-set-defaults.sh"]