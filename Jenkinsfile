pipeline {
    agent none
    stages {
        stage('Clone Step') {
            agent { label 'java' }
            steps {
                sh 'rm -rf hello-world-war'
                sh 'git clone https://github.com/darshansp1/hello-world-war.git'
            }
        }
        stage('Build Stage') {
            agent any
            steps {
                sh 'mvn package'
            }
        }
    }
}
