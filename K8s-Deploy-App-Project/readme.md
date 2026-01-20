Created a Docker image for the application
Deployed the app using Kubernetes Deployment YAML
Exposed the application using a Service (NodePort / LoadBalancer)
Configured replicas for high availability
Verified auto-healing by deleting pods and observing automatic recreation
Performed rolling updates without downtime

I deployed my Flask-based web application on Kubernetes using a Deployment and a Service. The Deployment manages multiple replicas for high availability and self-healing, while the NodePort Service exposes the application externally. Kubernetes automatically recreates pods if they fail and allows rolling updates without downtime.

Why Deployment instead of Pod?
Answer:
“A Pod runs a single instance of an application, but it doesn’t handle scaling or failures. A Deployment manages Pods automatically using ReplicaSets, which allows scaling, self-healing, and rolling updates. That’s why Deployments are used in real environments.”

One-liner:
Pod = single instance
Deployment = management + scaling + reliability

What happens if one pod crashes?
  Answer:
  “If a pod crashes, Kubernetes automatically detects it and creates a new pod to maintain the desired number of replicas defined in the Deployment. This ensures high availability and self-healing.”

  Simple explanation:
  Kubernetes replaces the failed pod automatically — no manual intervention.

Difference between NodePort and LoadBalancer?
  Answer:
  “NodePort exposes the application on a fixed port on each node, mainly used for testing or local setups. LoadBalancer creates an external load balancer provided by the cloud, which is used in production to distribute traffic automatically.”

  Table-style (easy to remember):
  NodePort → Testing / Minikube / Lab
  LoadBalancer → Production / Cloud (AWS, Azure)

How do rolling updates work?
  Answer:
  “Rolling updates allow updating the application without downtime by gradually replacing old pods with new ones. Kubernetes creates new pods first and only terminates old pods after the new ones are ready.”

  Key benefit:
  Zero downtime deployment

20-Second Combined Answer (Very Strong)

“I used a Deployment because it provides scaling, self-healing, and rolling updates, unlike a standalone Pod. If a pod crashes, Kubernetes automatically recreates it. I used a NodePort service for testing, while LoadBalancer is used in production. Rolling updates ensure new versions are deployed without downtime.”
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
When Minikube is run manually, it integrates with the user’s desktop network and browser, so service URLs are accessible. When Minikube is run by Jenkins, it runs in a headless service environment with no GUI and isolated networking, so NodePort URLs are only reachable locally. That’s why port-forwarding or Ingress is required. >>>>>>>>       kubectl port-forward svc/employee-app-service 8090:80
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
“Explain your DevOps project”
  Sample Answer:
  I built a CI/CD pipeline using Jenkins to deploy a Dockerized web application on a Minikube Kubernetes cluster. Jenkins pulls code from GitHub, builds a Docker image, pushes it to Docker Hub, and deploys the application using Kubernetes Deployment and Service YAML files. I exposed the application using a NodePort service and validated deployment using kubectl and browser access.

1️⃣ “You deployed an app using Jenkins and Minikube. How did you access the application?”
  Your answer (short):
  I exposed the application using a NodePort service and accessed it via Minikube IP. Since Jenkins runs Minikube in a headless environment, I used kubectl port-forward for stable browser access.
OR
  I initially exposed the application using a NodePort service. Since Minikube runs locally, I accessed it using the Minikube IP and NodePort.
  When running via Jenkins, I used kubectl port-forward to expose the service on localhost for stable browser access.

2️⃣ “Why did the Minikube service URL work locally but not when run from Jenkins?”
  Answer:
  Minikube service URLs are accessible only within the host machine. When Minikube runs via Jenkins, it runs as a background service user without desktop networking, so the NodePort URL is not reachable externally.
OR
  When Minikube is run manually, it integrates with the user’s desktop networking, so the service URL works in the browser.
  When Minikube is run by Jenkins, it runs as a headless service user without a GUI, and the Minikube IP is only reachable locally on the Jenkins machine, not externally.

3️⃣ “curl works but browser doesn’t. Why?”
  Answer:
  curl was executed on the Jenkins host where the Minikube network is reachable. The browser was on a different machine, so the internal Minikube IP was not routable.
OR
  curl was executed on the Jenkins host where the Minikube network is accessible.
  The browser was running on a different machine, so it couldn’t route traffic to Minikube’s internal IP.

4️⃣ “How did you fix the browser access issue?”
  Answer:
  I used kubectl port-forward to expose the service on localhost, avoiding Minikube’s internal VM networking.
OR
  I used kubectl port-forward to forward the service port to localhost, which avoids Minikube’s internal VM networking and works reliably even in a Jenkins environment.

5️⃣ “Why didn’t you use NodePort in production?”
  Answer:
  NodePort is suitable for local testing, but in production I would use Ingress or a LoadBalancer for stable external access.
                                                      OR
  NodePort is suitable for local testing but not ideal for production due to limited security and fixed port ranges. In production, I would use an Ingress controller or a cloud LoadBalancer.

6️⃣ “Why did your Docker build fail initially?”
  Answer:
  The Dockerfile was stored in a sub-directory. Jenkins was running the build from repository root, so I fixed it using the dir() step in Jenkinsfile.
OR
  The Dockerfile was stored in a sub-directory of the repository. Jenkins runs commands from the workspace root, so Docker couldn’t find the Dockerfile.
  I fixed this by using the dir() step in Jenkinsfile to change into the correct directory.

7️⃣ “Why is Jenkins running docker commands without sudo?”
  Answer:
  The Jenkins user was added to the docker group to allow Docker CLI access without root privileges.
OR
  The Jenkins user was added to the Docker group, allowing it to run Docker CLI commands without requiring root privileges.

8️⃣ “Why is minikube start not recommended in every pipeline run?”
  Answer:
  Starting Minikube repeatedly increases pipeline time and resource usage. Ideally, the cluster should already be running and Jenkins should only deploy applications.

9️⃣ “Difference between ClusterIP, NodePort, and LoadBalancer?”
  Sample Answer:
  ClusterIP exposes the service only inside the cluster.
  NodePort exposes it on a node’s IP and port.
  LoadBalancer provisions an external load balancer, mainly used in cloud environments.

🔟 “How does Kubernetes Service route traffic to Pods?”
  answer:
  Kubernetes Services use label selectors to identify Pods.
  Traffic sent to the service is routed to one of the matching Pods using kube-proxy.

1️⃣1️⃣ “How would this change on AWS EKS?”
  Sample Answer:
  On EKS, I would deploy the application similarly, but expose it using a LoadBalancer or Ingress, which provides a public endpoint automatically.

1️⃣2️⃣ “How would you improve this pipeline for production?”
  Sample Answer:
  I would add image tagging with build numbers, rollout status checks, secret management, and separate CI and CD stages for better control.
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
🎤 2-Minute DevOps Project Explanation
I implemented a CI/CD pipeline using Jenkins to deploy a containerized web application on Kubernetes using Minikube.
The source code is hosted on GitHub. Jenkins is configured with a declarative pipeline that automatically pulls the code, builds a Docker image, and pushes it to Docker Hub.
The application is containerized using Docker, and Kubernetes Deployment and Service YAML files are used to manage pod replicas and expose the application.
During deployment, I faced an issue where the application was accessible when running Minikube manually, but not when Minikube was triggered through Jenkins. I debugged this by verifying service endpoints and testing connectivity using curl.
I identified that Minikube was running in a headless Jenkins environment, so the NodePort URL was only reachable locally. To fix this, I used kubectl port-forward to expose the service on localhost, which made the application accessible reliably.
This project helped me gain hands-on experience with Jenkins pipelines, Docker image management, Kubernetes service networking, and real-world troubleshooting in CI/CD environments.
