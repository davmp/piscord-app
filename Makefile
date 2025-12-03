NAMESPACE=piscord
K8S_DIR=k8s/

.PHONY: help deploy restart logs delete status

help:
	@echo ""
	@echo "Available commands:"
	@echo "  make deploy     - Apply all Kubernetes manifests"
	@echo "  make restart    - Restart frontend and backend deployments"
	@echo "  make logs       - Tail logs for all pods"
	@echo "  make delete     - Delete the full Kubernetes app"
	@echo "  make status     - Show pod and service status"
	@echo ""

# --------------------------------------------------------
# Create K3S Cluster
# --------------------------------------------------------
cluster-up:
	@echo "📦 Creating K3S cluster..."
	k3d cluster create piscord \
		--servers 1 \
		--agents 2 \
		--port 80:80@loadbalancer \
		--port 443:443@loadbalancer
	@echo "🚀 Cluster piscord created."

# --------------------------------------------------------
# Delete K3S Cluster
# --------------------------------------------------------
cluster-down:
	@echo "📦 Deleting K3S cluster..."
	k3d cluster delete piscord
	@echo "🚀 Cluster piscord deleted."

# --------------------------------------------------------
# Deploy all YAML (frontend, backend, mongodb)
# --------------------------------------------------------
deploy:
	@echo "📦 Deploying Kubernetes resources..."
	kubectl apply -f $(K8S_DIR)namespace.yaml
	kubectl apply -f $(K8S_DIR)mongo/ -n $(NAMESPACE)
	kubectl apply -f $(K8S_DIR)redis/ -n $(NAMESPACE)
	kubectl apply -f $(K8S_DIR)backend/ -n $(NAMESPACE)
	kubectl apply -f $(K8S_DIR)worker/ -n $(NAMESPACE)
	kubectl apply -f $(K8S_DIR)frontend/ -n $(NAMESPACE)
	kubectl apply -f $(K8S_DIR)ingress.yaml
	@echo "🚀 Deployment complete."

# --------------------------------------------------------
# Restart deployments (after image push or config change)
# --------------------------------------------------------
restart:
	@echo "🔄 Restarting backend..."
	kubectl rollout restart deployment backend -n $(NAMESPACE)
	@echo "🔄 Restarting frontend..."
	kubectl rollout restart deployment frontend -n $(NAMESPACE)
	@echo "🔄 Restarting redis..."
	kubectl rollout restart deployment redis -n $(NAMESPACE)
	@echo "🔄 Restarting worker..."
	kubectl rollout restart deployment worker -n $(NAMESPACE)
	@echo "✔ All services restarted."

# --------------------------------------------------------
# View logs (follows all running pods)
# --------------------------------------------------------
logs:
	@echo "📜 Fetching logs..."
	kubectl logs -n $(NAMESPACE) -l app=backend -f &
	kubectl logs -n $(NAMESPACE) -l app=frontend -f &
	kubectl logs -n $(NAMESPACE) -l app=redis -f &
	kubectl logs -n $(NAMESPACE) -l app=mongo -f &
	kubectl logs -n $(NAMESPACE) -l app=worker -f

# --------------------------------------------------------
# Delete everything
# --------------------------------------------------------
delete:
	@echo "🗑 Deleting Kubernetes resources..."
	kubectl delete -f $(K8S_DIR)frontend/ -n $(NAMESPACE) --ignore-not-found
	kubectl delete -f $(K8S_DIR)backend/ -n $(NAMESPACE) --ignore-not-found
	kubectl delete -f $(K8S_DIR)mongo/ -n $(NAMESPACE) --ignore-not-found
	kubectl delete -f $(K8S_DIR)redis/ -n $(NAMESPACE) --ignore-not-found
	kubectl delete -f $(K8S_DIR)worker/ -n $(NAMESPACE) --ignore-not-found
	kubectl delete namespace $(NAMESPACE) --ignore-not-found
	@echo "❌ All resources removed."

# --------------------------------------------------------
# View status
# --------------------------------------------------------
status:
	@echo "🔍 Listing pods and services in namespace $(NAMESPACE)..."
	kubectl get pods -n $(NAMESPACE)
	@echo ""
	kubectl get svc -n $(NAMESPACE)