FROM python:3.12.3-bullseye

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

#RUN python -m venv local

RUN pip install --no-cache-dir -r requirements.txt

#RUN chmod +x /app/startup_script.sh

CMD ["/bin/bash", "-c", "sleep infinity"]
# last arg is the context
# docker build -t NAME -f DOCKERFILE . 

# docker run -it NAME bash 

#cd localvenv