pipeline {
    agent any
    stages {
        stage('Run Tests') {
            parallel {
                stage('Test On Windows') {
                    steps {
                        bat "run-tests.bat"
                    }
                }
                stage('Test On Linux') {
                    steps {
                        sh "run-tests.sh"
                    }
                }
            }
        }
    }
}
