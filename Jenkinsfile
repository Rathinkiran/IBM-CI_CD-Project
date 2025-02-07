
pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        ECR_REPO = '941377151228.dkr.ecr.us-east-1.amazonaws.com/my-app'
        ECS_CLUSTER = 'my-cluster'
        ECS_SERVICE = 'my-service'
        TASK_DEFINITION = 'my-task'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/your-username/your-repo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $ECR_REPO:latest .'
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO
                docker push $ECR_REPO:latest
                '''
            }
        }

        stage('Update ECS Task & Deploy') {
            steps {
                sh '''
                aws ecs update-service --cluster $ECS_CLUSTER --service $ECS_SERVICE --force-new-deployment
                '''
            }
        }
    }
}
