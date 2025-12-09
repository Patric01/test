pipeline {
    agent any

    environment {
        DOCKERHUB_USER  = 'patric01'
        IMAGE_NAME      = 'patric01/test'
        IMAGE_TAG       = 'latest'
        DOCKERHUB_CREDS = 'dockerhub-creds'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                    echo '=== Building Docker Image ==='
                    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                """
            }
        }

        stage('Login & Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKERHUB_CREDS}",
                    usernameVariable: 'DOCKERHUB_USERNAME',
                    passwordVariable: 'DOCKERHUB_PASSWORD'
                )]) {

                    sh """
                        echo '=== Logging into DockerHub ==='
                        echo "${DOCKERHUB_PASSWORD}" | docker login -u "${DOCKERHUB_USERNAME}" --password-stdin

                        echo '=== Pushing Image ==='
                        docker push ${IMAGE_NAME}:${IMAGE_TAG}

                        echo '=== Logout ==='
                        docker logout
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Imaginea ${IMAGE_NAME}:${IMAGE_TAG} a fost construita si incarcata cu succes!"
        }
        failure {
            echo "Pipeline-ul a esuat. Verifica logurile."
        }
    }
}
