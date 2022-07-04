pipeline {
  agent any
  stages {
        stage('Clone step') {
            steps {
                sh 'git clone https://github.com/darshansp1/hello-world-war.git'
            }
        }
    stage('Build') {
            steps {
                sh 'mvn package'
            }
        }
    }
}
