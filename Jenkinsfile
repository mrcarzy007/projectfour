pipeline {
    agent any
 
      parameters{
        choice(name: "IMAGE_TAG", choices:["v1", "v2", "v3", "latest"], description: "Select Image Tag")
      }

    stages{
        stage("1 SonarQube Scan"){
            steps{
                echo "Scanning code for Bugs"
                withSonarQubeEnv('SonarQube'){
                    sh '''
                sonar-scanner \
                -Dsonar.projectKey=my-python \
                -Dsonar.sources=. \
                -Dsonar.host.url=http://3.80.127.44:9000 \
                -Dsonar.login=sqa_4202215858d710d2845cba76489b5afc76812ec7
                '''
                }
                
            }
         }

        stage("1 build the Docker image"){
       steps{
            echo "this is docker build image"
            sh "docker build -t devopsaditya123/app-slim:${params.IMAGE_TAG} . "
        }
        }
        
        stage("2 Docker Hub push image"){
          steps{
             withCredentials([usernamePassword(credentialsId: "docker-pass", usernameVariable: "USER", passwordVariable: "PASS")]){
                      sh "echo $PASS | docker login -u $USER --password-stdin"
                      sh "docker push devopsaditya123/app-slim:${params.IMAGE_TAG}"
              }
          }
        }
          
    }
}