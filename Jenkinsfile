pipeline {
    agent any

    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/<your-username>/<your-repo>.git'
            }
        }

        stage('Setup Ansible') {
            steps {
                sh '''
                sudo yum install -y ansible
                ansible-galaxy collection install community.docker
                '''
            }
        }

        stage('Deploy Containers using Ansible') {
            steps {
                sh '''
                ansible-playbook -i "localhost," -c local appdir/docker_java_mysql.yml
                '''
            }
        }
    }

    post {
        success {
            echo "Deployment Successful! Java app and MySQL are running."
        }
        failure {
            echo "Deployment failed! Check Jenkins logs."
        }
    }
}
