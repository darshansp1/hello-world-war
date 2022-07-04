pipeline {
  agent any
  stages {
        stage('Clone step') {
            steps {
                sh 'rm -rf hello-world-war'
                sh 'git clone https://github.com/darshansp1/hello-world-war.git'
            }
        }
    stage('Build') {
            steps {
                sh 'rm -rf job6_piplinejob2'
                sh 'rm -rf job6_piplinejob2@tmp'
                sh 'mvn package'
            }
        }
    }
}
