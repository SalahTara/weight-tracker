/* Requires the Docker Pipeline plugin */
pipeline {
    agent { docker { image 'python:3.14.7-alpine3.24' } }
    stages {
        stage('build') {
            steps {
                sh 'python --version'
            }
        }
    }
}