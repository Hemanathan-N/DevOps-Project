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



