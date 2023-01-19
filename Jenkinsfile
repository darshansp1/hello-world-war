pipeline {
    agent any
    stages {
        stage('Run Tests') {
            parallel {
                stage('Test On Windows') {
                        when (BRANCH_NAME != 'master') {
        echo 'Excecuted only on master branch.'
    }
                    steps {
                        bat "run-tests.bat"
                    }
                }
                stage('Test On Linux') {
                        when (BRANCH_NAME != 'master') {
        echo 'Excecuted only on master branch.'
    }
                    steps {
                        sh "run-tests.sh"
                    }
                }
            }
        }
    }
}
