FROM python:3.12.3-bullseye
MAINTAINER franz@nakamotomining.ai

RUN apt-get update && \
    apt-get install -y tmux npm curl libhdf5-dev && \
    npm install pm2@latest -g

SHELL ["/bin/bash", "-c"]

WORKDIR /app

COPY doc /app
COPY env /app
COPY resources /app
COPY LICENSE /app
COPY README.md /app
COPY requirements.txt /app
COPY src /app/src

COPY startup-script.sh /app
RUN chmod +x startup-script.sh

RUN pip install --no-cache-dir -r requirements.txt

CMD ["./startup-script.sh"]