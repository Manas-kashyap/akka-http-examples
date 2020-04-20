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
		}
	}
}