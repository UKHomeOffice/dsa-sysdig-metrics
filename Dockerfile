FROM quay.io/ukhomeofficedigital/python-alpine:3.7.6-alpine3.11
RUN mkdir -p /APP/scripts/
RUN mkdir -p /APP/scripts-copy/
RUN apk update
RUN apk upgrade
RUN apk add bash
RUN apk add jq
RUN apk add curl
RUN apk add --update busybox-suid
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin
ENV USERMAP_UID 1000
WORKDIR /APP/scripts/
EXPOSE 8000
EXPOSE 8080
RUN apk --no-cache add dcron libcap

RUN chown 1000:1000 /usr/sbin/crond \
    && setcap cap_setgid=ep /usr/sbin/crond

COPY --chown=1000:1000 scripts/cronjob /APP/cronjob
RUN crontab /APP/cronjob

COPY --chown=1000:1000 scripts/entrypoint.sh /APP/entrypoint.sh

RUN pip install requests
RUN pip install schedule
COPY scripts/ /APP/scripts/
COPY scripts/ /APP/scripts-copy/
RUN adduser -D -H 1000 && chown -R 1000 /APP
RUN chmod -R +x /APP/scripts
RUN chmod 755 /usr/bin/crontab
RUN chmod -R 775 /etc/crontabs
RUN chown -R root:1000 /etc/crontabs
RUN chmod -R +x /APP/scripts-copy
USER ${USERMAP_UID}
ENTRYPOINT ["./entrypoint.sh"]
