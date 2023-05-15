pipeline {
  agent any
  
  environment {
    registry = credentials('DOCKER_ID')
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  
  stages {
    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build("${registry}/id", "./docker") + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Push Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
          dockerImage.push()
          }
        }
      }
    }
    stage('Cleanup') {
      steps {
        bat "docker rmi $registry/id:$BUILD_NUMBER"
      }
    }
  }
}
