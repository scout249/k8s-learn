# Secrets and ConfigMap Demo

In this demo, a multi-container application is prepared for use in Kubernetes. 
The goal of this demos is to show:
- ConfigMap allows you to decouple environment-specific configuration from your container images.
- Secrets are similar to ConfigMaps but are specifically intended to hold confidential data.
- Multiple pod referencing the same secret.

## Prerequisites

To be able to run the demos you must have a Kubernetes cluster.

## The demos

1. Create a secret

	```
	kubectl apply -f mongodb-secret.yaml
	```

	The output is similar to:
	```
	secret/mongodb-secret created
	```

1. Create a ConfigMap

	```
	kubectl apply -f mongo-configmap.yaml
	```

	The output is similar to:
	```
	configmap/mongo-configmap created
	```

1. Create mongodb backend pod and service

	```
	kubectl apply -f mongodb-deployment.yaml
	```

	The output is similar to:
	```
	deployment.apps/mongodb-deployment created
	service/mongodb-service created
	```

1. Create mongo express frontend pod and service

	```
	kubectl apply -f mongo-express-deployment.yaml
	```

	The output is similar to:
	```
	deployment.apps/mongo-express-deployment created
	service/mongo-express-service created
	```

1. View the frontend

	```
	kubectl get svc
	```

	The output is similar to:
	```
	NAME                    TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
	kubernetes              ClusterIP      10.96.0.1        <none>        443/TCP          6h49m
	mongo-express-service   LoadBalancer   10.106.126.148   <pending>     8081:30000/TCP   21s
	mongodb-service         ClusterIP      10.103.205.6     <none>        27017/TCP        99s
	```

	```
	minikube service list
	```

	The output is similar to:
	```
	|---------------|------------------------------------|--------------|---------------------------|
	|   NAMESPACE   |                NAME                | TARGET PORT  |            URL            |
	|---------------|------------------------------------|--------------|---------------------------|
	| default       | kubernetes                         | No node port |
	| default       | mongo-express-service              |         8081 | http://172.21.82.91:30000 |
	| default       | mongodb-service                    | No node port |
	| kube-system   | kube-dns                           | No node port |
	|---------------|------------------------------------|--------------|---------------------------|
	```

	Open http://172.21.82.91:30000 in web browser.