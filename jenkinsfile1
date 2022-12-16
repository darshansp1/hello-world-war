pipeline {
    agent none
    stages {
        stage('clone step') {
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
  
  
      stage('Deploy step') {
            steps {
                sh 'sudo cp /var/lib/jenkins/workspace/job1/target/hello-world-war-1.0.0.war /opt/apache-tomcat-9.0.64/webapps/'      
            }
        }
    }
}
