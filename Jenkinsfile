pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo "Building weight-tracker #${env.BUILD_NUMBER} (commit ${env.GIT_COMMIT})"
                sh 'make build'
            }
        }
        stage('Test') {
            steps {
                sh '''
                    node --version
                    echo ======== Starting Test Execution: ========
                    npx playwright test
                '''
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}

