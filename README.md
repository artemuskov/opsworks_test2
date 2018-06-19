# OpsWorks_test1

Task definition:

Create dockerized Nginx server with GitHub webhook deployment triggering using Jenkins pipelines (Jenkinsfile). 

Stages:

Build. Compile the latest version of Nginx server with a lua-nginx-module.

Dockerize. Create a docker image with adding custom nginx.conf and index.html from the repository files. Push docker image to the public Docker registry.

Deploy. Deploy Nginx container on EC2 instance using docker-machine.


Continuous deployment should start by push event to the git repository master branch.


It’s necessary to tag EC2 instances with name/surname when working on the test task, otherwise, they will be terminated.


Output: 


Push the final code revision to a public GitHub repository and share URL link to it.

Do NOT expose provided AWS credentials in public repository.  
