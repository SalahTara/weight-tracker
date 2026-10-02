pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                 sh '''
                    set +x
                    echo "Building weight-tracker ${BUILD_NUMBER} (commit ${GIT_COMMIT})"
                    'make build'
                '''
                // sh 'echo "Building weight-tracker #${env.BUILD_NUMBER} (commit ${env.GIT_COMMIT})"'
                // sh 
                
            }
        }
        stage('Test') {
            steps {
                sh '''
                    set +x
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

