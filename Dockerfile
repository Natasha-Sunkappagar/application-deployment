FROM tomcat:9-jdk11-openjdk-slim

WORKDIR /usr/local/tomcat/webapps/ROOT

COPY index.html .
COPY FormServlet.java .
COPY WEB-INF ./WEB-INF

# Install javac properly
RUN apt-get update && apt-get install -y openjdk-11-jdk

RUN javac -cp /usr/local/tomcat/lib/servlet-api.jar:. -d WEB-INF/classes FormServlet.java
RUN rm -f FormServlet.java

EXPOSE 8080
CMD ["catalina.sh", "run"]

