pipeline {
    agent any
    environment {
	    AWS_ACCOUNT_ID='966981673260'
		AWS_DEFAULT_REGION='us-west-2'
		IMAGE_REPO_NAME='ecr-pipeline-builddemo'
		IMAGE_TAG='latest'
		REPOSITORY_URL = '${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}'
	}

    stages {
        stage('Log in to Aws ECR') {
            steps {
                script {
			  sh 'aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com'
			  }
            }
        }

        stage('checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Anudeep0070/microservice-in-python.git']]])
            }
        }
        stage('Build') {
            steps {
                sh 'python3 main.py'
            }
        }
        stage('Building Docker Image') {
            steps {
                script {
                    dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
			  }
            }
        }
        stage('Pushing to ECR') {
            steps {
                script {
                    sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URL}:${IMAGE_TAG}"
                    sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
			  }
            }
        }
    }
}
