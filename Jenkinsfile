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
                sh 'docker build -t cicd-group2 .'
            }
        }
        stage('Push to AWS ECR') {
            steps {
                sh 'docker tag cicd-group2:latest 135671754298.dkr.ecr.us-east-1.amazonaws.com/cicd-group2:latest'
                sh 'docker push 135671754298.dkr.ecr.us-east-1.amazonaws.com/cicd-group2:latest'
            }
        }
        stage ('Deploy Application') {
            steps {
                sh '''
                   ssh -l aaron_delrosario -i ~/.ssh/codecommit_rsa 192.168.200.227 << EOF
                   eval $(aws ecr get-login --no-include-email)
                   docker service rm cicd-group2
                   docker pull 135671754298.dkr.ecr.us-east-1.amazonaws.com/cicd-group2:latest
                   sh /opt/devops/CICD/service_group2.sh
                '''
            }
        }
    }
}
