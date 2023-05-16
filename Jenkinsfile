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
          def dockerImage = docker.build("${registry}/id:$BUILD_NUMBER", "./docker")
          dockerImage.push()
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
            powershell '''
              "Get-ChildItem "kustomization.yaml" -Recurse | ForEach (Get-Content $_ | ForEach  { $_ -replace "{{BUILD_NUMBER}}", '$BUILD_NUMBER' }) }"
               kubectl apply -k ./sitecore
            '''
          }
        }
      }
    }
  }
}
