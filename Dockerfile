FROM ubuntu:latest

ENV PATH="/usr/games:${PATH}"

WORKDIR /app

COPY . .

RUN apt-get update && apt-get install -y fortune-mod cowsay netcat-openbsd

RUN chmod 755 wisecow.sh

EXPOSE 4499

CMD ["./wisecow.sh"]
