FROM tomcat:9-jdk11-openjdk-slim

WORKDIR /usr/local/tomcat/webapps/ROOT

# Copy HTML and Java servlet source files
COPY index.html .
COPY FormServlet.java .

# Install javac (Java compiler)
RUN apt-get update && apt-get install -y javac

# Create proper WEB-INF/classes directory
RUN mkdir -p WEB-INF/classes

# Compile servlet into correct folder
RUN javac -cp /usr/local/tomcat/lib/servlet-api.jar:. -d WEB-INF/classes FormServlet.java

# (Optional but recommended) Clean up .java file after compilation
RUN rm -f FormServlet.java

EXPOSE 8080
CMD ["catalina.sh", "run"]
