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
          dockerImage = docker.build("${DOCKER_ID}/cd", "./docker")
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
        sh "docker rmi ${DOCKER_ID}/cd:$BUILD_NUMBER"
        sh "docker rmi ${DOCKER_ID}/cd:latest"
      }
    }
  }
}
