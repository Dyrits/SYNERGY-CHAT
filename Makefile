minikube:
	minikube start --extra-config "apiserver.cors-allowed-origins=["http://boot.dev"]"
	minikube dashboard --port=63840

deploy:
	# kubectl create ns crawler
	kubectl apply -f web-configmap.yaml
	kubectl apply -f api-configmap.yaml
	kubectl apply -f crawler-configmap.yaml
	kubectl apply -f testram-configmap.yaml
	kubectl apply -f web-hpa.yaml
	kubectl apply -f testcpu-hpa.yaml
	kubectl apply -f web-deployment.yaml --force
	kubectl apply -f api-deployment.yaml --force
	kubectl apply -f crawler-deployment.yaml --force
	kubectl apply -f testcpu-deployment.yaml --force
	kubectl apply -f testram-deployment.yaml --force
	kubectl apply -f web-service.yaml
	kubectl apply -f api-service.yaml
	kubectl apply -f crawler-service.yaml
	kubectl apply -f app-ingress.yaml
	kubectl apply -f api-pvc.yaml

serve:
	kubectl proxy

add-ons:
	minikube addons enable ingress
	minikube addons enable metrics-server

tunnel:
	minikube tunnel -c