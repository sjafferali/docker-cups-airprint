ARG BASE_VERSION=latest
FROM jstrader/airprint-cloudprint:$BASE_VERSION

RUN apt-get update \
    && apt-get install -y samba-client \
    # setup default cups config
    && cp -R /usr/etc/cups/* /etc/cups/

COPY cups/cupsd.conf cups/printers.conf /etc/cups/
COPY ppd/Epson-RX520.ppd /etc/cups/ppd/
COPY healthcheck.sh /
RUN chmod +x /healthcheck.sh

HEALTHCHECK --interval=10s --timeout=3s CMD /healthcheck.sh

#ENV CUPS_IP="127.0.0.1"
