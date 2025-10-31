FROM tomcat:9-jdk11-openjdk-slim

WORKDIR /usr/local/tomcat/webapps/ROOT

# Copy app files
COPY index.html .
COPY FormServlet.java .
COPY WEB-INF ./WEB-INF

# Install javac
RUN apt-get update && apt-get install -y javac

# Compile servlet
RUN javac -cp /usr/local/tomcat/lib/servlet-api.jar:. -d WEB-INF/classes FormServlet.java

# Clean up
RUN rm -f FormServlet.java

EXPOSE 8080
CMD ["catalina.sh", "run"]

