pipeline {
  agent { label 'Built-In Node' }
  stages {
        stage('Clone step') {
            steps {
                sh 'rm -rf hello-world-war'
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
