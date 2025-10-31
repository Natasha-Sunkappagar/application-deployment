pipeline {
    agent any

    environment {
        ANSIBLE_HOST_KEY_CHECKING = 'False'
        JAVA_HOME = '/usr/lib/jvm/java-11-openjdk'
        PATH = "$JAVA_HOME/bin:$PATH"
    }

    stages {

        stage('Cleanup Workspace') {
            steps {
                echo "Cleaning previous workspace..."
                deleteDir()
            }
        }

        stage('Checkout Code') {
            steps {
                echo "Checking out latest code..."
                git branch: 'main', url: 'https://github.com/Natasha-Sunkappagar/application-deployment.git'
            }
        }

        stage('Setup Environment') {
            steps {
                sh '''
                # Ensure Ansible is installed
                if ! command -v ansible-playbook &> /dev/null; then
                    echo "Installing Ansible..."
                    sudo yum install -y ansible
                fi

                # Ensure Python 3.9 is present (if not)
                if ! python3.9 --version &>/dev/null; then
                    echo "Installing Python 3.9..."
                    sudo dnf install -y python39
                fi
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                echo "Building Docker image for Java + Tomcat..."
                docker build -t myapp:latest .
                '''
            }
        }

        stage('Deploy Containers using Ansible') {
            steps {
                echo "Deploying containers to managed nodes..."
                sh '''
                ansible-playbook -i inventory.ini docker_java_mysql.yml
                '''
            }
        }
    }

    post {
        success {
            echo "Deployment Successful! Java app and MySQL are running."
        }
        failure {
            echo " Deployment failed! Check Jenkins logs for details."
        }
    }
}

