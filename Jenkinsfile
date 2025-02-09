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
                git credentialsId: 'github-credentials', url: 'https://github.com/Rathinkiran/IBM-CI_CD-Project.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                sudo 'docker build -t $ECR_REPO:latest .'
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                sudo '''
                aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO
                docker push $ECR_REPO:latest
                '''
            }
        }

        stage('Update ECS Task & Deploy') {
            steps {
                sudo '''
                aws ecs update-service --cluster $ECS_CLUSTER --service $ECS_SERVICE --force-new-deployment
                '''
            }
        }
    }
}
