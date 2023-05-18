pipeline {
  agent any
  
  environment {
    registry = credentials('DOCKER_ID')
    registryCredential = 'dockerhub'
  }
  
  stages {
    stage('Build And Push image') {
      steps{
        script {
          docker.withRegistry('', 'dockerhub') {
            def dockerImage = docker.build("${registry}/id:$BUILD_NUMBER", "./docker")
            dockerImage.push()
          }  
        }
      }
    }
    stage('Clean Image') {
      steps {
        bat "docker rmi $registry/id:$BUILD_NUMBER"
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
