node {
	stage ('SCM Checkout'){
		git credentialsId: 'github', url: 'https://github.com/artemuskov/opsworks_test2.git'
	}
    
    stage ('Build docker image nginx-lua'){
        sh 'docker build -t artemuskov/nginx-lua:latest .'
    }

	stage ('Push docker image nginx-lua into dockerhub'){
		withCredentials([string(credentialsId: 'dockerhubpass', variable: 'dockerhubpass')]) {
			sh "docker login -u artemuskov -p ${dockerhubpass}"
		}
		sh 'docker push artemuskov/nginx-lua:latest'
    }
}
