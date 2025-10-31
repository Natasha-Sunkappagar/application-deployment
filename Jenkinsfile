pipeline {
    agent none

    stages {
        stage('Build in Java container') {
            agent {
                docker {
                    image 'openjdk:8-jdk-alpine'   // lightweight Java build container
                    args '-v $WORKSPACE:/app'     // mount workspace into container
                }
            }
            steps {
                sh '''
                    echo "Compiling Java source..."
                    mkdir -p appdir
                    javac -cp /usr/share/java/servlet-api.jar:. FormServlet.java -d appdir
                    echo "Compilation completed."
                '''
            }
        }

        stage('Package WAR') {
            agent {
                docker {
                    image 'openjdk:8-jdk-alpine'
                    args '-v $WORKSPACE:/app'
                }
            }
            steps {
                sh '''
                    echo "Packaging into WAR..."
                    mkdir -p build/WEB-INF/classes
                    cp -r appdir/* build/WEB-INF/classes/
                    mkdir -p build/WEB-INF/lib
                    cd build && jar -cvf myapp.war *
                    echo "WAR package created successfully."
                '''
            }
        }

        stage('Deploy on Tomcat Container') {
            agent {
                docker {
                    image 'tomcat:9.0-jdk8'
                    args '-p 8080:8080'
                }
            }
            steps {
                sh '''
                    echo "Deploying WAR to Tomcat..."
                    cp build/myapp.war /usr/local/tomcat/webapps/
                    echo "Application deployed on Tomcat container."
                    echo "Tomcat running at http://localhost:8080/myapp"
                    sleep 10
                '''
            }
        }
    }
}

