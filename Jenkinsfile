pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('Dockerhub') // Set Docker Hub credentials ID
        GITHUB_CREDENTIALS = credentials('github')         // Set GitHub credentials ID
        DOCKER_HUB_REPO = 'dibyadarshandevops/project6'    // Your Docker Hub repository
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the Git repository using the specified credentials
                git branch: 'main', credentialsId: "${GITHUB_CREDENTIALS}", url: 'https://github.com/Dibyadarshan9777/project6.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build("${env.DOCKER_HUB_REPO}:latest")
                }
            }
        }

        stage('Test') {
            steps {
                // Run your test cases (make sure you have tests defined in your repo)
                sh 'pytest' // Replace with your test command if necessary
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_HUB_CREDENTIALS}") {
                        docker.image("${env.DOCKER_HUB_REPO}:latest").push('latest') // Use 'latest' tag for pushing
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs() // Clean workspace after the job completes
        }
    }
}
