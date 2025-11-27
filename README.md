# Piscord – Real-time Full Stack Chat Application 🚀

Piscord is a real-time chat application inspired by modern platforms, built to demonstrate a robust and scalable architecture. This repository contains the **Kubernetes infrastructure and deployment manifests** to orchestrate the Piscord services.

The application is composed of:
-   **Frontend**: Angular 17+ (Material, PrimeNG)
-   **Backend**: Go (Gorilla Mux, WebSocket)
-   **Database**: MongoDB & Redis

## 📋 Prerequisites

To run this project locally, ensure you have the following tools installed:

-   [Docker](https://www.docker.com/)
-   [k3d](https://k3d.io/) (Lightweight Kubernetes wrapper for Docker)
-   [kubectl](https://kubernetes.io/docs/tasks/tools/)
-   [Make](https://www.gnu.org/software/make/)

## 🚀 Quick Start

You can spin up the entire environment with a few commands using the provided `Makefile`.

### 1. Create the Cluster
Initialize a local K3s cluster named `piscord` with load balancer support.

```bash
make cluster-up
```

### 2. Deploy Resources
Apply all Kubernetes manifests (Namespace, MongoDB, Backend, Frontend, Ingress).

```bash
make deploy
```

### 3. Access the Application
Once deployed, the application should be accessible at:

-   **Frontend**: `http://localhost:80` (or `https://localhost:443`)

> **Note**: It may take a minute for all pods to reach `Running` status. You can check the status with `make status`.

## 🛠️ Available Commands

The `Makefile` provides several utility commands to manage the lifecycle of the application:

| Command | Description |
| :--- | :--- |
| `make cluster-up` | Creates a new k3d cluster named `piscord`. |
| `make cluster-down` | Deletes the `piscord` k3d cluster. |
| `make deploy` | Applies all K8s manifests (`k8s/`) to the cluster. |
| `make restart` | Restarts frontend and backend deployments (useful after image updates). |
| `make logs` | Tails logs for frontend, backend, and mongodb pods simultaneously. |
| `make status` | Shows the current status of pods and services in the `piscord` namespace. |
| `make delete` | Removes all deployed resources from the cluster (keeps the cluster running). |

## 🏗️ Architecture & Directory Structure

This repository focuses on the **Infrastructure as Code (IaC)** aspect.

```text
.
├── k8s/
│   ├── backend/      # Backend Deployment & Service
│   ├── frontend/     # Frontend Deployment & Service
│   ├── mongodb/      # MongoDB StatefulSet & Service
│   ├── namespace.yaml
│   └── ingress.yaml
├── Makefile          # Automation scripts
└── README.md         # Documentation
```

## 🔗 References

For the source code of the application services, please visit:

-   **Frontend Repository**: [piscord-app-frontend](https://github.com/davmp/piscord-app-frontend)
-   **Backend Repository**: [piscord-app-backend](https://github.com/davmp/piscord-app-backend)
