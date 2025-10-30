FROM tomcat:9-jdk11-openjdk-slim

WORKDIR /usr/local/tomcat/webapps/ROOT

# Copy form and servlet files
COPY index.html .
COPY FormServlet.java .

# Install javac for compilation
RUN apt-get update && apt-get install -y javac

# Compile the servlet
RUN javac -cp /usr/local/tomcat/lib/servlet-api.jar:. FormServlet.java

EXPOSE 8080
CMD ["catalina.sh", "run"]
