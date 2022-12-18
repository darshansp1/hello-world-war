pipeline {
    agent slave1
    stages {
        stage('Clone Step') {
            steps {
                sh 'rm -rf hello-world-war'
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
