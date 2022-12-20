pipeline {
    agent any
    stages {
        stage('1') {
            steps {
                sh 'exit 0'
            }
        }
        stage('2') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh "exit 1"
                }
            }
        }
        stage('3') {
            steps {
                catchError(message: "Test failed", stageResult: 'UNSTABLE', buildResult: 'UNSTABLE') 
                sh 'exit 0'
            }
        }
    }
}
