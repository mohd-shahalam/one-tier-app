pipeline {
    agent any

    stages {
        stage('Git checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/mohd-shahalam/one-tier-app.git'
            }
        }
        stage('Sending Docker File to Ansible Server Over SSH') {
            steps {
                sshagent(['jenkins-ssh']) {
					sh 'git clone https://github.com/mohd-shahalam/one-tier-app.git'
                    sh 'scp -o StrictHostKeyChecking=no /home/ubuntu/one-tier-app/* ubuntu@172.31.31.93:/home/ubuntu/'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                sshagent(['jenkins-ssh']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.31.93 "docker build -t nginx-image /home/ubuntu/"'
                }
            }
        }
        stage('Tag and Push Docker Image') {
            steps {
                sshagent(['jenkins-ssh']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.31.93 "docker tag nginx-image shahalam8535/nginx-image:latest && docker push shahalam8535/nginx-image:latest"'
                }
            }
        }
        stage('Copy FIles from Ansible to K8s server ') {
            steps {
                sshagent(['jenkins-ssh']) {
					sh 'git clone https://github.com/mohd-shahalam/one-tier-app.git'
                    sh 'scp -o StrictHostKeyChecking=no /home/ubuntu/one-tier-app/k8s/* ubuntu@172.31.24.209:/home/ubuntu/one-tier-app/k8s/*'
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed'
        }
        success {
            echo 'Pipeline succeeded'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}

