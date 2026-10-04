// Posts a commit status to GitHub so the build shows up in the PR's checks box.
// Needs a Jenkins "Secret text" credential named 'github-api-token'
// (a GitHub token with commit statuses: write on SalahTara/weight-tracker).
def setGitHubStatus(String state, String description) {
    withCredentials([string(credentialsId: 'github-api-token', variable: 'GH_API_TOKEN')]) {
        sh """
            set +x
            # PR builds check out a merge commit; its second parent is the PR's head commit.
            if [ -n "\$CHANGE_ID" ] && git rev-parse -q --verify HEAD^2 >/dev/null; then
                SHA=\$(git rev-parse HEAD^2)
            else
                SHA=\$(git rev-parse HEAD)
            fi
            curl -sS --fail-with-body -o /dev/null -X POST \\
              -H "Authorization: Bearer \$GH_API_TOKEN" \\
              -H "Accept: application/vnd.github+json" \\
              https://api.github.com/repos/SalahTara/weight-tracker/statuses/\$SHA \\
              -d '{"state":"${state}","context":"Jenkins","description":"${description}","target_url":"${env.BUILD_URL}"}'
        """
    }
}

pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script { setGitHubStatus('pending', "Build #${env.BUILD_NUMBER} running") }
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
        success { script { setGitHubStatus('success', 'Build and tests passed') } }
        failure { script { setGitHubStatus('failure', 'Build or tests failed') } }
        aborted { script { setGitHubStatus('error', 'Build was aborted') } }
    }
}
