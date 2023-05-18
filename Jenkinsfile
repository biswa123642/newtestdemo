pipeline {
  agent any
  
  environment {
    registryuser = credentials('DOCKER_ID')
    registrypass = credentials('DOCKER_PASS')
  }
  
  stages {
    stage('Build And Push image') {
      steps{
        script {
          bat "type ${registrypass}| docker login -u ${registryuser}--password-stdin"
          def dockerImage = docker.build("${registryuser}/id:$BUILD_NUMBER", "./docker")
          dockerImage.push()
        }
      }
    }
    stage('Clean Image') {
      steps {
        bat "docker rmi $registryuser/id:$BUILD_NUMBER"
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
