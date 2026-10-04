def setStatus(String state, String desc) {
    withCredentials([string(credentialsId: 'github-api-token', variable: 'GH_API_TOKEN')]) {
        sh """
            set +x
            SHA=\$(git rev-parse HEAD)
            curl -sS -X POST \\
                -H "Authorization: Bearer \$GH_API_TOKEN" \\
                -H "Accept: application/vnd.github+json" \\
                https://api.github.com/repos/SalahTara/weight-tracker/statuses/\$SHA \\
                -d
'{"state":"${state}","context":"jenkins/playwright","description":"${desc}","target_url":"${env.BUILD_URL}"}'
        """
    }
}

pipeline {
    agent any

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
                    echo "================================ Starting Test Execution: ================================"
                    npx playwright test
                    echo "================================ Finished Test Execution: ================================"
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
                    set +x
                    echo "================ Starting Deployment of weight-tracker ${BUILD_NUMBER} to Vercel... ================"
                    make deploy
                    echo "================ Finished Deploying weight-tracker ${BUILD_NUMBER} to Vercel... ================"

                '''
            }
        }
    }

    post {
        success { script { setStatus('success', 'All Tests Passed')}}
        failure { script { setStatus('failed', 'Build or Tests Failed')}}

    }
}

