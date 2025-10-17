FROM openjdk:11-jdk-slim

WORKDIR /usr/src/app

COPY javaservlet.java .
COPY index.html .

RUN javac javaservlet.java
RUN apt-get update && apt-get install -y python3

EXPOSE 8080
CMD ["sh", "-c", "python3 -m http.server 8080"]
