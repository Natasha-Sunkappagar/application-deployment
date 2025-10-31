pipeline {
    agent {
        docker {
            image 'tomcat:9-jdk11-openjdk-slim'  // ✅ includes servlet-api.jar
            args '-u root:root -p 8080:8080'     // root to allow copy, exposes 8080
        }
    }

    environment {
        JAVA_HOME = '/usr/lib/jvm/java-11-openjdk'
        PATH = "$JAVA_HOME/bin:$PATH"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Natasha-Sunkappagar/application-deployment.git'
            }
        }

        stage('Build and Package WAR') {
            steps {
                sh '''
                    echo " Compiling Java source..."
                    mkdir -p build/WEB-INF/classes
                    javac -cp /usr/local/tomcat/lib/servlet-api.jar:. FormServlet.java -d build/WEB-INF/classes

                    echo " Creating WAR..."
                    cp index.html build/
                    cd build && jar -cvf myapp.war *
                    cd ..
                    echo "WAR created successfully: build/myapp.war"
                '''
            }
        }

        stage('Deploy on Tomcat') {
            steps {
                sh '''
                    echo " Deploying WAR to Tomcat..."
                    cp build/myapp.war /usr/local/tomcat/webapps/
                    echo "Tomcat running at: http://localhost:8080/myapp"
                    sleep 10
                '''
            }
        }
    }

    post {
        success {
            echo " Build and deployment successful!"
        }
        failure {
            echo " Build or deployment failed. Check logs."
        }
    }
}

