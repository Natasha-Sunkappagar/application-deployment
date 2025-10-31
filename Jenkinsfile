pipeline {
    agent any

    environment {
        INVENTORY = 'inventory.ini'
        PLAYBOOK = 'docker_java_mysql.yml'
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    echo "Installing Ansible and Docker SDK if not installed..."
                    if ! command -v ansible >/dev/null 2>&1; then
                        sudo dnf install -y ansible python3-docker
                    fi
                '''
            }
        }

        stage('Deploy Containers on EC2 Nodes') {
            steps {
                sh '''
                    echo "Running Ansible playbook to deploy containers on managed EC2 instances..."
                    ansible-playbook -i ${INVENTORY} ${PLAYBOOK}
                '''
            }
        }
    }

    post {
        success {
            echo " Deployment successful — App & DB containers running on all EC2 nodes!"
        }
        failure {
            echo " Deployment failed — check Jenkins or Ansible logs for details."
        }
    }
}

