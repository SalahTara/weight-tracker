pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                 sh '''
                    #!/bin/bash
                    set +x
                    echo "Building weight-tracker #${env.BUILD_NUMBER} (commit ${env.GIT_COMMIT})"
                    sh 'make build'
                '''
                
            }
        }
        stage('Test') {
            steps {
                sh '''
                    #!/bin/bash
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

