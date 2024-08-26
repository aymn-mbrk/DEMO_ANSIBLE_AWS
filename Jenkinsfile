pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Get the repo
               git branch: 'main', url: 'git@github.com:aymn-mbrk/DEMO_ANSIBLE.git'
            }
        }

        stage('Run Ansible') {
            steps {
                script {
                    // Deploy the ansible playbook
                    sh 'ansible-playbook -i inventory/gcp.yaml TESTS/playbook-test1.yml'
                }
            }
        }

        
    
    }
}

