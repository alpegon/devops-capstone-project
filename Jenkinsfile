pipeline {
  environment {
    registry = "alpegon/price-prediction"
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
            sh 'pylint --disable=R,C,W1203 app.py'
          }
        }

        stage('Hadolint') {
          agent {
            docker {
              image 'hadolint/hadolint'
            }

          }
          steps {
            sh 'hadolint Dockerfile'
          }
        }

      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
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

  }
}
