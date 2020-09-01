pipeline {
  agent none
  
  stages {

    stage('Build') {
      agent {
        docker {
          image 'registry2.efilmcloud.com/library/kaniko-executor:debug-v0.24.0'
          args  "--entrypoint=''"
          registryUrl 'https://registry2.efilmcloud.com/'
          registryCredentialsId 'registry2'
        }
      }

      steps {
        echo env.BRANCH_NAME
        echo env.WORKSPACE
        sh "/kaniko/executor --skip-unused-stages --context ${env.WORKSPACE} --dockerfile Dockerfile --destination registry2.efilmcloud.com/library/centos7-docker:${env.BRANCH_NAME} --cache=true --cache-ttl=240h --verbosity=info"
      }
    }
  }
}

