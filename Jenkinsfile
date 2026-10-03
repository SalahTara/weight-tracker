pipeline {
    agent any

    environment {
        VERCEL_ORG_ID     = 'team_xxx...'
        VERCEL_PROJECT_ID = 'prj_xxx...'
    }
    stages {
        stage('Build') {
            steps {
                 sh '''
                    set +x
                    echo "Building weight-tracker ${BUILD_NUMBER} (commit ${GIT_COMMIT})"
                    make build
                '''
             
                
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
                when {
                    expression {
                        branch 'test' && currentBuild.result == 'SUCCESS'
                    }
                }     
            steps {
                echo 'Deploying....'
            }
        }
    }
}

