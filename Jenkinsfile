#!groovy
properties([
  parameters([
    string(defaultValue: '1.4.0', description: 'Packer Version', name: 'PackerVersion')
  ])
])

node {
  packerVersion = params.PackerVersion
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
    }
  }
}
