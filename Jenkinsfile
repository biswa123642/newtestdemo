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
          dockerImage = docker.build("${registry}/cd", "./docker")
        }
      }
    }
    stage('Push Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
          dockerImage.push("$BUILD_NUMBER")
          }
        }
      }
    }
    stage('Cleanup') {
      steps {
        bat "docker rmi $registry/cd:$BUILD_NUMBER"
      }
    }
  }
}
