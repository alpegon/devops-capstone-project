pipeline {
  environment {
    appFolder = 'app'
    appDockerfile = 'containers/app/Dockerfile'
    kubeFolder = 'kubernetes'
    awsCredentials = 'aws-eks'
    awsRegion = 'us-west-2'
    eksClusterName = 'capstone'
    deployment = 'house-price-prediction'
    registry = 'alpegon/house-price-prediction'
    registryCredential = 'dockerhub'
    dockerImage = '' 
  }

  agent any
  stages {
    stage('Linting') {
      parallel {
        stage('Pylint') {
          agent {
            docker {
              image 'alpegon/pylint'
            }

          }
          steps {
            sh "pylint --disable=R,C,W1203 $appFolder/app.py"
          }
        }

        stage('Hadolint') {
          agent {
            docker {
              image 'alpegon/hadolint'
            }

          }
          steps {
            sh "hadolint $appDockerfile"
          }
        }

      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          dockerImage = docker.build(registry + ":$BUILD_NUMBER", "-f $appDockerfile .")
        }
      }
    }

    stage('Deploy Docker Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    
    stage('Set Kubectl Config') {
      agent {
        docker {
          image 'alpegon/kubeops'
        }
      }
      steps {
        withEnv(['HOME=.']){
          withAWS(credentials: "$awsCredentials", region: "$awsRegion") {
            sh "aws eks update-kubeconfig --name $eksClusterName"
            stash name: "kube-config", includes: ".kube/*"
          }
        }
      }
    }
    
    stage('Rolling Deployment') {
      agent {
        docker {
          image 'alpegon/kubeops'
        }
      }
      steps {
        withEnv(['HOME=.']){
          withAWS(credentials: "$awsCredentials", region: "$awsRegion") {
            unstash "kube-config"
            sh "sed \"s+$registry+$registry:$BUILD_NUMBER+g\" kubernetes/app-deployment.yml > kubernetes/new-deployment.yml"
            sh "kubectl apply -f $kubeFolder/new-deployment.yml"
            sh "kubectl apply -f $kubeFolder/app-service.yml"
          }
        }
      }
    }
    
    stage('Clean Environment') {
      steps {
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }         

  }
}
