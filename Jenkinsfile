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
                    echo "Building weight-tracker ${BUILD_NUMBER} (commit ${GIT_COMMIT})..."
                    make build
                '''
             
                
            }
        }
        stage('Test') {
            steps {
                sh '''
                    set +x
                    node --version
                    echo "======== Starting Test Execution: ========"
                    npx playwright test
                    echo "======== Finished Test Execution: ========"
                '''
            }
        }
        stage('Deploy') {
            when {
                    branch 'master'
                    
            } 
                
            environment {
                VERCEL_TOKEN      = credentials('vercel-token')
                VERCEL_ORG_ID     = 'team_fsqceJMFR2ejvHSsRCbiR6Dp'  
                VERCEL_PROJECT_ID = 'prj_ZiiS5kvtMcg18fQmsOtwvUmj8fEd'    
            }

            steps {
                sh ''' 
                    set -x
                    echo "Deploying weight-tracker ${BUILD_NUMBER} to Vercel..."
                    make deploy
                '''
            }
        }
    }
}

