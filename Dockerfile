FROM busybox

ADD curl-7.30.0.ermine.tar.bz2 /opt
ADD jq-linux32 /bin/jq
ADD loop.sh /opt/loop.sh

RUN mv /opt/curl-7.30.0.ermine/curl.ermine /bin/curl && \
    chmod +x /bin/jq && \
    chmod +x /opt/loop.sh


CMD /opt/loop.sh

