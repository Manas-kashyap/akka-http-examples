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
							tool name: 'sbt', type: 'org.jvnet.hudson.plugins.SbtPluginBuilder$SbtInstallation'
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
                expression { env.BRANCH_NAME ==~ /(tests|features)/ }
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
			stage ('Packaging the Archive') {
				when {
					branch 'master'
				}
				steps {
					sh 'sbt assembly'
				}
			}
			// stage ('Archiving the Artifacts') {
			// 	steps {
			// 		dir('target/scala-2.11') {
			// 			step([$class: 'ArtifactArchiver', artifacts: 'akka-http-helloworld-assembly-1.0.jar'])
			// 		}
			// 	}
			// }
			stage ('Deploying on the server') {
				when {
					branch 'master'
				}
				input {
					message "Deploy to the Prod server ?"
				}
				steps {
					sh './Jenkins/deploy.sh'
				}
			}
		}
		post {
			always {
				mail to: 'manas.kashyap@knoldus.com',
				subject: "Pipeline: ${currentBuild.fullDisplayName} is ${currentBuild.currentResult}",
				body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}"
			}
		}
	}
