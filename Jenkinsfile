pipeline {
    agent none

    stages {

        stage('Build with Maven') {
            agent {
                docker {
                    image 'maven:3.8.8-eclipse-temurin-11'
                    args '-v $WORKSPACE:/app'
                }
            }
            steps {
                sh '''
                    echo "Building WAR file using Maven..."
                    mvn clean package -DskipTests
                '''
            }
        }

        stage('Deploy to Tomcat Container') {
            agent {
                docker {
                    image 'tomcat:9.0-jdk11'
                    args '-p 8080:8080'
                }
            }
            steps {
                sh '''
                    echo "Deploying WAR to Tomcat..."
                    cp target/*.war /usr/local/tomcat/webapps/
                    echo "Application deployed to Tomcat container at http://localhost:8080"
                    sleep 15
                '''
            }
        }
    }

    post {
        failure {
            echo " Build or deployment failed. Check logs."
        }
        success {
            echo " Application deployed successfully on Tomcat container!"
        }
    }
}

