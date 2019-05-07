#!groovy
latest = "1.4.0"
stable = "1.4.0"

properties([
  parameters([
    string(defaultValue: '1.4.0', description: 'Version', name: 'Version')
  ])
])

node {
  packerVersion = params.Version
  credentialsId = 'docker-hub-credentials'

  stage('clone') {
    checkout scm
  }

  stage('build') {
    image = docker.build("jbussdieker/packer:${packerVersion}", "--build-arg packer_version=${packerVersion} .")
  }

  stage('test') {
    image.inside {
      sh "packer version | grep ${packerVersion}"
    }
  }

  stage('publish') {
    docker.withRegistry("", credentialsId) {
      image.push()
      if (packerVersion == latest)
        image.push('latest')
      else if (packerVersion == stable)
        image.push('stable')
    }
  }
}
