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
          dockerImage = docker.build("${registry}/id", "./docker")
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
    stage('Clean Image') {
      steps {
        bat "docker rmi $registry/id:$BUILD_NUMBER"
        bat "docker rmi $registry/id:latest"
      }
    }
    stage('Deploy Image') {
      steps {
        script {
          kubeconfig(credentialsId: 'dockerhub') {
            bat "kubectl apply -f"
          }
        }
      }
    }
  }
}
