FROM ubuntu:latest

WORKDIR /app

COPY . .

RUN apt update && apt install -y fortune-mod cowsay

RUN chmod 755 wisecow.sh

EXPOSE 4499

CMD ["./wisecow.sh"]
