pipeline {
    agent any
    stages {
        stage('Tests') {
            options { 
                catchError(message: "Test failed", stageResult: 'UNSTABLE', buildResult: 'UNSTABLE') 
            } 
            stages {
                stage('Test 1') {
                    echo 'test 1 succeeded'
                }        
                stage('Test 2') {
                    error 'test 2 failed'
                }        
            }
        }
    }
}
