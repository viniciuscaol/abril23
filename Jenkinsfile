pipeline{
    agent any

    stages {

        stage ('Build Docker Image') {
            steps {
                script {
                    dockerapp = docker.build("viniciuscaol/desafio04:v1.0.${env.BUILD_ID}", '-f ./Desafio04/kube-news/src/dockerfile ./Desafio04/kube-news/src')
                }
            }
        }
    }
}