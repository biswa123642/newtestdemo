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
    stage('Deploy Image') {
      steps {
        script {
          kubernetesDeploy(configs: "hellowhale.yml", kubeconfigId: "mykubeconfig")
        }
      }
    }
  }
}
