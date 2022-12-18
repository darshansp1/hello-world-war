pipeline {
    agent any
    stages {
        stage('Clone Step') {
            steps {
                sh 'git clone https://github.com/darshansp1/hello-world-war.git'
            }
        }
        stage('Build Stage') {
            steps {
                sh 'mvn package'
            }
        }
    }
}
