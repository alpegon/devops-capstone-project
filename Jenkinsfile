pipeline {
  agent any
  stages {
    stage('Pylint') {
      parallel {
        stage('Pylint') {
          steps {
            dockerNode(image: 'alpegon/pylint') {
              sh 'pylint --disable=R,C,W1203 app.py'
            }

          }
        }

        stage('Hadolint') {
          steps {
            dockerNode(image: 'hadolint/hadolint') {
              sh 'hadolint Dockerfile'
            }

          }
        }

      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t alpegon/price-prediction .'
      }
    }

  }
}