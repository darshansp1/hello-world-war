pipeline {
    agent any	
	 
 stages {
      stage('checkout') {
           steps {             
                git branch: 'master', url: 'https://github.com/darshansp1/hello-world-war.git'             
          }
        }       

  stage('Docker Build and Tag') {
           steps {  
		 
                sh 'sudo docker build -t jenkinsassignment:latest .' 
                sh 'sudo docker tag jenkinsassignment darshansp111/jenkinsassignment:latest' 
            }
        }

stage('Login to Docker hub') {
           steps {
              
                sh 'sudo docker login --username=darshansp111 --password=94836024001A*a'
          }
        }
     
  stage('Publish image to Docker Hub') {
          
            steps {
       	  sh  'sudo docker push darshansp111/jenkinsassignment:latest'  
        }                 
          
        }     
      stage('Run Docker container on Jenkins Agent') {
             
            steps 
	      {
                sh "sudo docker run -d -p 8004:8080 darshansp111/jenkinsassignment:latest"
             }
        }
	 
 
    }
	}
