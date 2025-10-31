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

                # Ensure Python 3.9 is present
                if ! python3.9 --version &>/dev/null; then
                    echo "Installing Python 3.9..."
                    sudo dnf install -y python39
                fi
                '''
            }
        }

        stage('Build Java Application') {
            steps {
                sh '''
                echo "Compiling Java source..."
                mkdir -p appdir
                javac -cp . FormServlet.java -d appdir
                cd appdir
                jar cf myapp.jar *
                cd ..
                echo "JAR created successfully at appdir/myapp.jar"
                '''
            }
        }

        stage('Deploy with Ansible') {
            steps {
                echo "Running Ansible playbook to build and deploy containers..."
                sh '''
                ansible-playbook -i inventory.ini docker_java_mysql.yml --tags "build_and_deploy"
                '''
            }
        }
    }

    post {
        success {
            echo " Deployment Successful! Containers running on managed nodes."
        }
        failure {
            echo " Deployment failed! Check Jenkins and Ansible logs."
        }
    }
}

