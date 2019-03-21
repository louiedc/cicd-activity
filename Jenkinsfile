pipeline {
    agent any
    triggers {
        pollSCM '* * * * *'
    }
    stages {
        stage ('ECR Login') {
            steps {
                sh 'eval $(aws ecr get-login --no-include-email)'
            }
        }
        stage ('Docker Build') {
            steps {
                sh 'docker build -t cicd-group1 .'
            }
        }
        stage('Push to AWS ECR') {
            steps {
                sh 'docker tag cicd-group1:latest 135671754298.dkr.ecr.us-east-1.amazonaws.com/cicd-group1:latest'
                sh 'docker push 135671754298.dkr.ecr.us-east-1.amazonaws.com/cicd-group1:latest'
            }
        }
        stage ('Deploy Application') {
            steps {
                sh '''
                   ssh -l aaron_delrosario -i ~/.ssh/codecommit_rsa 192.168.200.227 << EOF
                   eval $(aws ecr get-login --no-include-email)
                   docker service rm cicd-group1
                   docker pull 135671754298.dkr.ecr.us-east-1.amazonaws.com/cicd-group1:latest
                   sh /opt/devops/CICD/service_group1.sh
                '''
            }
        }
    }
}
