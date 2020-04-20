pipeline {
	agent any 
	triggers { pollSCM('H */4 * * 1-5') }
	options {
        timeout(time: 1, unit: 'HOURS') 
        retry(2)
         buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
        }
		stages {
			stage ('Parallel Stage of Installing Dependency') {
				parallel {
					stage ('Dependency installation in ubuntu slave') {
						agent {
							label 'ubuntu-slave'
						}
						steps {
							sh './Jenkins/dependency.sh'
						}
					}
					stage ('Dependency installation in debian slave') {
						agent {
							label 'debian-slave'
						}
						steps {
							sh './Jenkins/dependency.sh'
						}
					}
				}
			}
			stage ('Compile the Package for Different Distro') {
				parallel {
					stage ('Compile the Package for Ubuntu') {
						agent {
							label 'ubuntu-slave'
						}
						steps {
							sh 'sbt clean compile'
						}
					}
					stage ('Compile the Package for Debian') {
						agent {
							label 'debian-slave'
						}
						steps {
							sh 'sbt clean compile'
						}
					}
				}
			}
			stage ('Running the Tests for Different Distro') {
				when {
					branch 'tests'
				}
				parallel {
					stage ('Running the Tests in Ubuntu') {
						agent {
							label 'ubuntu-slave'
						}
						steps {
							sh 'sbt test'
						}
					}
					stage ('Running the Tests in Debian') {
						agent {
							label 'debian-slave'
						}
						steps {
							sh 'sbt test'
						}
					}
				}
			}

		}
	}
