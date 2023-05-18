pipeline {
  agent any
  
  environment {
    DATE = new Date().format('yy.M')
    TAG = "${DATE}.${BUILD_NUMBER}"
    registry = credentials('DOCKER_ID')
    registryCredential = 'dockerhub'
  }
  
  stages {
    stage('Build And Push Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            def dockerImage = docker.build("${registry}/id:$TAG", "./docker")
            dockerImage.push()
          }  
        }
      }
    }
    stage('Clean Image') {
      steps {
        bat "docker rmi $registry/id:$TAG"
      }
    }
    stage('Deploy Image') {
      steps {
        script {
          kubeconfig(credentialsId: 'kubeid') {
            bat "kubectl apply -k ./sitecore"
          }
        }
      }
    }
  }
}
