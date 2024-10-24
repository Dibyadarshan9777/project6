pipeline {
    agent {
        docker {
            image 'jenkins/jenkins:lts'
            volumes {
                hostPath volume: '/home/elliot/.minikube/profiles/minikube', containerPath: '/minikube'
            }
        }
    }

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub')
        GITHUB_CREDENTIALS = credentials('github')
        DOCKER_HUB_REPO = 'dibyadarshandevops/project6'
        DOCKER_IMAGE_TAG = 'latest'
        WEBAPP_HELM_CHART = '/home/elliot/Desktop/test/test-project/my-kube'
        PROMETHEUS_HELM_CHART = '/home/elliot/Desktop/test/test-project/my-prometheous/my-prom'
        KUBECONFIG = '/minikube/config'  // Update the KUBECONFIG to match the mounted path
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    git branch: 'master', credentialsId: 'github', url: 'https://github.com/Dibyadarshan9777/project6.git'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    docker.build("${env.DOCKER_HUB_REPO}:${env.DOCKER_IMAGE_TAG}")
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    echo 'Logging into Docker Hub...'
                    sh "echo \$DOCKER_HUB_CREDENTIALS_PSW | docker login -u \$DOCKER_HUB_CREDENTIALS_USR --password-stdin"
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo 'Pushing Docker image to Docker Hub...'
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                        docker.image("${env.DOCKER_HUB_REPO}:${env.DOCKER_IMAGE_TAG}").push("${DOCKER_IMAGE_TAG}")
                    }
                }
            }
        }

        stage('Deploy Web Application with Helm') {
            steps {
                script {
                    echo 'Deploying Web App using Helm...'
                    sh """
                        export KUBECONFIG=${KUBECONFIG}
                        helm upgrade --install project6 ${WEBAPP_HELM_CHART} \
                        --set image.repository=${DOCKER_HUB_REPO} \
                        --set image.tag=${DOCKER_IMAGE_TAG}
                    """
                }
            }
        }

        stage('Deploy Prometheus with Helm') {
            steps {
                script {
                    echo 'Deploying Prometheus using Helm...'
                    sh """
                        export KUBECONFIG=${KUBECONFIG}
                        helm upgrade --install my-prometheus ${PROMETHEUS_HELM_CHART} \
                        --set prometheus.image.tag=${DOCKER_IMAGE_TAG}
                    """
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
