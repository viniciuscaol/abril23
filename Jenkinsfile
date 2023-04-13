pipeline{
    agent any

    stages {

        stage ('Build Docker Image') {
            steps {
                script {
                    dockerapp = docker.build("viniciuscaol/desafio04:v1.2.${env.BUILD_ID}", '-f ./Desafio04/kube-news/src/dockerfile ./Desafio04/kube-news/src')
                }
            }
        }

        stage ('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        dockerapp.push('latest')
                        dockerapp.push("v1.2.${env.BUILD_ID}")
                    }
                }
            }
        }

        stage ('Deploy Kubernetes') {
            environment {
                tag_version = "${env.BUILD_ID}"
            }
            steps {
                withKubeConfig ([credentialsId: 'kubeconfig']) {
                    sh 'sed -i "s/{{TAG}}/$tag_version/g" ./Desafio04/kube-news/k8s/api/deployment.yaml'
                    sh 'kubectl apply -f ./Desafio04/kube-news/k8s -R'
                }
            }
        }
    }
}