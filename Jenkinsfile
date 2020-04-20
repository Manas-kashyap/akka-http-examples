pipeline {
	agent any {
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
		}
	}
}