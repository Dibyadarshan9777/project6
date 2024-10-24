pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub')
        GITHUB_CREDENTIALS = credentials('github')
        DOCKER_HUB_REPO = 'dibyadarshandevops/project6'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'master', credentialsId: "${GITHUB_CREDENTIALS}", url: 'https://github.com/Dibyadarshan9777/project6.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${env.DOCKER_HUB_REPO}:latest")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_HUB_CREDENTIALS}") {
                        docker.image("${env.DOCKER_HUB_REPO}:latest").push('latest')
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
