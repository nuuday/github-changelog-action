FROM docker.io/alpine:latest

COPY entrypoint.sh /entrypoint.sh
RUN apk add --no-cache git && \
    wget https://github.com/git-chglog/git-chglog/releases/download/v0.14.2/git-chglog_0.14.2_linux_amd64.tar.gz && \
        tar xvf git-chglog_0.14.2_linux_amd64.tar.gz && \
        mv git-chglog /usr/local/bin/git-chglog && \
    chmod 755 /entrypoint.sh /usr/local/bin/git-chglog

ENTRYPOINT [ "/entrypoint.sh" ]
