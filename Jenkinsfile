pipeline{
    agent any

    stages {

        stage ('Build Docker Image') {
            steps {
                script {
                    dockerapp = docker.build("viniciuscaol/desafio04:v1.1.${env.BUILD_ID}", '-f ./Desafio04/kube-news/src/dockerfile ./Desafio04/kube-news/src')
                }
            }
        }

        stage ('Push Docker Image'){
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub')
                        dockerapp.push('latest')
                        dockerapp.push("v1.1.${env.BUILD_ID}")
                }
            }
        }
    }
}