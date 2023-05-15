pipeline {
  agent any
  
  environment {
    DOCKER_ID = credentials('DOCKER_ID')
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  
  stages {
    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build("${DOCKER_ID}/cm", "./docker")
        }
      }
    }
    stage('Push Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
          dockerImage.push("$BUILD_NUMBER")
            dockerImage.push('latest')
          }
        }
      }
    }
    stage('Cleanup') {
      steps {
        echo 'Removing unused docker containers and images..'
        sh 'docker ps -aq | xargs --no-run-if-empty docker rm'
        // keep intermediate images as cache, only delete the final image
        sh 'docker images -q | xargs --no-run-if-empty docker rmi'
      }
    }
  }
}
