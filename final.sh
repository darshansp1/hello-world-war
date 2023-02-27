pipeline {
    agent { label "docker" }    //Run everything on an agent with the docker daemon
    environment {
        IMAGE = readMavenPom().getArtifactId()    //Use Pipeline Utility Steps
        VERSION = readMavenPom().getVersion()
    }
    stages {
        stage('Build') {
            agent {
                docker {
                    reuseNode true    //reuse the workspace on the agent defined at top-level\
                    image 'maven:3.5.0-jdk-8'
                }
            }
            steps {
                sh 'mvn clean install'
                junit(allowEmptyResults: true, testResults: '**/target/surefire-reports/TEST-*.xml')
            }
        }
        stage('Quality Analysis') {
            environment {
                SONAR = credentials('sonar') //use ‘sonar’ credentials
            }
            parallel {     // run Sonar Scan and Integration tests in parallel
                stage ("Integration Test"} {
                    steps {
                        echo 'Run integration tests here...'
                    }
                }
                stage("Sonar Scan") {
                    steps {
                        sh "mvn sonar:sonar -Dsonar.login=$SONAR_PSW"
                    }
                }
            }
        }
        stage('Build and Publish Image') {
            when {
                branch 'master'    //only run these steps on the master branch
            }
            steps {
                sh """
                    docker build -t ${IMAGE} .
                    docker tag ${IMAGE} ${IMAGE}:${VERSION}
                    docker push ${IMAGE}:${VERSION}
                """
            }
        stage('Publish Docker and Helm') {
            steps {
                echo "Stop and remove container"
                sh "docker stop ${ID}"

                echo "Packing helm chart"
                sh "${WORKSPACE}/build.sh --pack_helm --push_helm --helm_repo ${HELM_REPO} --helm_usr ${HELM_USR} --helm_psw ${HELM_PSW}"
            }
        }
		 stage('Deploy to dev') {
            steps {
                script {
                    namespace = 'development'

                    echo "Deploying application ${ID} to ${namespace} namespace"
                    createNamespace (namespace)

                    // Remove release if exists
                    helmDelete (namespace, "${ID}")

                    // Deploy with helm
                    echo "Deploying"
                    helmInstall(namespace, "${ID}")
                }
            }
        }

        // Run the 3 tests on the deployed Kubernetes pod and service
        stage('Dev tests') {
            parallel {
                stage('Curl http_code') {
                    steps {
                        curlTest (namespace, 'http_code')
                    }
                }
                stage('Curl total_time') {
                    steps {
                        curlTest (namespace, 'time_total')
                    }
                }
                stage('Curl size_download') {
                    steps {
                        curlTest (namespace, 'size_download')
                    }
                }
            }
        }

        stage('Cleanup dev') {
            steps {
                script {
                    // Remove release if exists
                    helmDelete (namespace, "${ID}")
                }
            }
        }

        ////////// Step 5 //////////
        stage('Deploy to staging') {
            steps {
                script {
                    namespace = 'staging'

                    echo "Deploying application ${IMAGE_NAME}:${DOCKER_TAG} to ${namespace} namespace"
                    createNamespace (namespace)

                    // Remove release if exists
                    helmDelete (namespace, "${ID}")

                    // Deploy with helm
                    echo "Deploying"
                    helmInstall (namespace, "${ID}")
                }
            }
        }
        stage('Cleanup staging') {
            steps {
                script {
                    // Remove release if exists
                    helmDelete (namespace, "${ID}")
                }
            }
        }
	}
	
du -ah /var/jenkins_home/
println new ProcessBuilder('sh','-c','du -h --max-depth=1 /var/jenkins_home/|sort -hr').redirectErrorStream(true).start().text


