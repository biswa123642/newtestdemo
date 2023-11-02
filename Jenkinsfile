pipeline {
  agent any
  
  environment {
    DATE = new Date().format('yyyy.MM.dd')
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
          dir('sitecore') {
            kubeconfig(credentialsId: 'kubeid', serverUrl: 'https://sitecoreak-rg-pl-dev-poc3-9485f0-94ul4jzg.hcp.eastus.azmk8s.io:443') {
              bat "kustomize edit set image nginx-image=*:$TAG"
              bat "kustomize build . | kubectl apply -f -"
            }
          }
        }
      }
    }
  }
}
