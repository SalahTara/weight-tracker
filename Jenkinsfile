pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo "Building weight-tracker #${env.BUILD_NUMBER} (commit ${env.GIT_COMMIT?})"
                sh 'make build'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                echo 'Testing 2nd Branch'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}

