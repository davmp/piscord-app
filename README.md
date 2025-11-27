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

## 🔒 Secrets & Configuration

> [!IMPORTANT]
> Before deploying, you **MUST** generate and fill in the secrets in the Kubernetes manifests. The application will not start correctly without them.

### 1. Generate Base64 Secrets
You can generate base64 encoded strings using the terminal:

```bash
# Example: Generate a base64 string for "mypassword"
echo -n "mypassword" | base64
```

### 2. Update Manifests
Update the following files with your generated values:

#### `k8s/backend/secret.yaml`
-   `JWT_SECRET`: Base64 encoded secret key for JWT tokens.

#### `k8s/mongodb/secret.yaml`
-   `MONGO_INITDB_ROOT_USERNAME`: Base64 encoded MongoDB root username.
-   `MONGO_INITDB_ROOT_PASSWORD`: Base64 encoded MongoDB root password.

#### `k8s/backend/configmap.yaml`
-   `MONGO_URI`: Update the connection string with your **plain text** (not base64) username and password.
    -   Format: `mongodb://<username>:<password>@mongodb.piscord.svc.cluster.local:27017/piscord?authSource=admin`

## 🔥 Quick Start

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
Once deployed, the application is accessible via:

-   **Localhost**: `http://localhost:80` (or `https://localhost:443`)
-   **LAN**: You can access the application from other devices on your local network using your machine's LAN IP address.

#### Find your LAN IP
To find your local IP address, run:

```bash
# Linux / macOS
ipconfig getifaddr en0   # macOS (Wi-Fi)
# OR
ifconfig | grep "inet " | grep -v 127.0.0.1
```

#### Custom Domain (Optional)
You can also access the application via `http://piscord.local` by adding an entry to your `/etc/hosts` file.

1.  Open `/etc/hosts` with sudo privileges:
    ```bash
    sudo nano /etc/hosts
    ```
2.  Add the following line (replace `<YOUR_LAN_IP>` with your actual IP, or use `127.0.0.1` for local only):
    ```text
    127.0.0.1   piscord.local
    ```
3.  Save and exit. You can now access the app at `http://piscord.local`.

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
