pipeline {
    agent any

    environment {
        // optional environment vars
        APP_NAME = "myapp"
        WAR_FILE = "target/myapp.war"
        TOMCAT_PORT = "8085"  // changed from 8080 to avoid conflict with Jenkins
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Checking out source code..."
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo "Building WAR file..."
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Deploy to Tomcat Container') {
            agent {
                docker {
                    image 'tomcat:9-jdk11-openjdk-slim'
                    args "-p ${TOMCAT_PORT}:8080"
                }
            }
            steps {
                echo "Deploying WAR file to Tomcat container..."
                sh '''
                    # Copy WAR file to Tomcat webapps
                    cp ${WAR_FILE} /usr/local/tomcat/webapps/${APP_NAME}.war

                    echo "Starting Tomcat..."
                    catalina.sh run &
                    sleep 20

                    echo "Application deployed successfully!"
                    echo "Access it at: http://localhost:${TOMCAT_PORT}/${APP_NAME}"
                '''
            }
        }
    }

    post {
        always {
            echo "Cleaning up..."
        }
        success {
            echo "Pipeline executed successfully!"
        }
        failure {
            echo "Pipeline failed! Please check the console output."
        }
    }
}

