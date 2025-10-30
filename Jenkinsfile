pipeline {
    agent any

    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Natasha-Sunkappagar/application-deployment.git'
            }
        }

        stage('Deploy Containers using Ansible') {
            steps {
                sh '''
                ansible-playbook -i inventory.ini docker_java_mysql.yml
                '''
            }
        }
    }

    post {
        success {
            echo " Deployment Successful! Java app and MySQL are running."
        }
        failure {
            echo " Deployment failed! Check Jenkins logs."
        }
    }
}
