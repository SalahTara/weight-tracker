/* Requires the Docker Pipeline plugin */
pipeline {
    agent { docker { image 'node:24.20.0-alpine3.24' } }
    stages {
        stage('build') {
            steps {
                sh 'node --version'
            }
        }
    }
}