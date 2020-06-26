pipeline {
  agent any
  stages {
    stage('Linting') {
      parallel {
        stage('Pylint') {
            agent {
                docker { image 'alpegon/pylint' }
            }
            steps {
                sh 'pylint --disable=R,C,W1203 app.py'
            }
          }
        }

        stage('Hadolint') {
            agent {
                docker { image 'hadolint/hadolint' }
            }
            steps {
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
