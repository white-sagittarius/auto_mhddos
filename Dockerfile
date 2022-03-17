LABEL org.opencontainers.image.source=https://github.com/Aruiem234/auto_mhddos

FROM python:3.10-alpine3.15 as builder
RUN apk update && apk add git curl gcc libc-dev libffi-dev
RUN git clone https://github.com/porthole-ascend-cinnamon/mhddos_proxy.git
WORKDIR /mhddos_proxy
RUN curl -O https://raw.githubusercontent.com/Aruiem234/mhddosproxy/main/proxies_config.json
RUN git clone https://github.com/MHProDev/MHDDoS.git
RUN pip3 install -r MHDDoS/requirements.txt --target dependencies

FROM python:3.10-alpine3.15
RUN apk update && apk add --no-cache bash curl
WORKDIR /root
COPY --from=builder /mhddos_proxy mhddos_proxy
ENV PYTHONPATH="${PYTHONPATH}:/root/mhddos_proxy/dependencies"
COPY runner.sh runner.sh

ENTRYPOINT ["bash", "runner.sh"]
