pipeline {
    agent any
    environment {
        IMAGE_NAME = "hemanathan18/employee-app"
        KUBE_CONFIG = "/var/lib/jenkins/.kube/config"
    }
    stages {

        stage('Checkout Code') {
            steps {
                git 'https://github.com/Hemanathan-N/DevOps-Project.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                dir('K8s-Deploy-App-Project') {
                    sh 'docker build -t $IMAGE_NAME:latest .'
                }
            }
        }
        stage('Push Image to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                credentialsId: 'DockerHub', 
                passwordVariable: 'docker_pwd', 
                usernameVariable: 'docker_un')])  {
                    dir('K8s-Deploy-App-Project') {
                        sh '''
                        docker login -u ${docker_un} -p ${docker_pwd}
                        docker push $IMAGE_NAME:latest  
                        ''' 
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                dir('K8s-Deploy-App-Project/k8s') {
                    sh '''
                    kubectl get nodes
                    kubectl apply -f deployment.yml
                    kubectl apply -f service.yml
                    ''' 
                }
            }
        }
    }
    post {
        success {
            emailext(
                subject: "Jenkins Build Successful !",
                body: "Jenkins K8s-Deploy-App-pipeline completed successfully.",
                to: "hemeenufradus18180@gmail.com" 
            ) 
        }
        failure {
            emailext(
                subject: "Jenkins Build Failed !!",
                body: "Jenkins K8s-Deploy-App-pipeline failed. Please check logs.",
                to: "hemeenufradus18180@gmail.com"
            )
        }
    }
}
