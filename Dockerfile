FROM python:3.12.3-bullseye
MAINTAINER franz@nakamotomining.ai

RUN apt-get update && \
    apt-get install -y tmux npm curl libhdf5-dev && \
    npm install pm2@latest -g

SHELL ["/bin/bash", "-c"]

WORKDIR /app

COPY doc /app
COPY resources /app
COPY LICENSE /app
COPY README.md /app
COPY requirements.txt /app

COPY generate_ini.py /app
COPY startup_script.sh /app

COPY src /app/src

RUN pip install --no-cache-dir -r requirements.txt
RUN chmod +x startup_script.py
RUN chmod +x generate_ini.py

CMD ["./startup_script.sh"]