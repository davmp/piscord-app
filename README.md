# Piscord – Real-time Full Stack Chat Application 🚀

Piscord is a real-time chat application inspired by modern platforms, built to demonstrate a robust and scalable architecture. This repository contains the **Kubernetes infrastructure and deployment manifests** to orchestrate the Piscord services.

The application is composed of:

- **Frontend**: Angular 17+ (Material, PrimeNG)
- **Backend**: Go (Gorilla Mux, WebSocket)
- **Database**: MongoDB & Redis

## 📋 Prerequisites

To run this project locally, ensure you have the following tools installed:

- [Docker](https://www.docker.com/)
- [k3d](https://k3d.io/) (Lightweight Kubernetes wrapper for Docker)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Make](https://www.gnu.org/software/make/)

# Piscord – Real-time Full Stack Chat Application 🚀

Piscord is a scalable, real-time chat architecture composed of **Angular 17+**, **Go**, **MongoDB**, and **Redis**. This repository contains the **Kubernetes infrastructure (k3d)** and deployment manifests.

## 📋 Prerequisites

- [Docker](https://www.docker.com/)
- [k3d](https://k3d.io/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Make](https://www.gnu.org/software/make/)

## 🔒 Configuration (Required)

> [!IMPORTANT]
> You **MUST** update the secrets in `k8s/` before deploying. The app will not start without them.

1.  **Generate Base64 Secrets:** `echo -n "mypassword" | base64`
2.  **Update Manifests:**
    - `k8s/backend/secret.yaml`: Set `JWT_SECRET` (Base64).
    - `k8s/mongo/secret.yaml`: Set Root Username/Password (Base64).
    - `k8s/backend/configmap.yaml`: Set `MONGO_URI` (Plain text connection string).

## 🔥 Quick Start

Use the `Makefile` to spin up the environment in minutes.

1.  **Create Cluster:**
    ```bash
    make cluster-up
    ```
2.  **Deploy Resources:**
    ```bash
    make deploy
    ```

## 🚀 Accessing the Application

Once deployed (check with `make status`), the application is accessible via:

- **Localhost:** `http://localhost:80` (or `https://localhost:443`)
- **LAN (Other devices):** `http://<YOUR_LAN_IP>:80`
- **Custom Domain:** `http://piscord.local`

<details>
<summary><b>🛠️ Click here for LAN IP & Custom Domain Setup Guide</b></summary>

<br>

### 1. Finding Your LAN IP

Required for accessing the app from other devices on your network.

| OS          | Command                  | Note                                               |
| :---------- | :----------------------- | :------------------------------------------------- |
| **Linux**   | `ip a`                   | Look for `inet` on primary adapter (e.g., `eth0`). |
| **macOS**   | `ipconfig getifaddr en0` | IP of primary adapter.                             |
| **Windows** | `ipconfig`               | Look for **IPv4 Address**.                         |

### 2. Setting up `piscord.local`

Map the domain to `127.0.0.1` by editing your hosts file (Admin/Sudo required).

| OS                | Command                                         | Action                                            |
| :---------------- | :---------------------------------------------- | :------------------------------------------------ |
| **Linux / macOS** | `sudo nano /etc/hosts`                          | Add: `127.0.0.1 piscord.local`                    |
| **Windows**       | `notepad C:\Windows\System32\drivers\etc\hosts` | Open as **Admin**. Add: `127.0.0.1 piscord.local` |

</details>

> **Note**: It may take a minute for all pods to reach `Running` status. You can check the status with `make status`.

## 🛠️ Commands

The `Makefile` provides several utility commands to manage the lifecycle of the application:

| Command             | Description                                                                  |
| :------------------ | :--------------------------------------------------------------------------- |
| `make cluster-up`   | Creates a new k3d cluster named `piscord`.                                   |
| `make cluster-down` | Deletes the `piscord` k3d cluster.                                           |
| `make deploy`       | Applies all K8s manifests (`k8s/`) to the cluster.                           |
| `make restart`      | Restarts frontend and backend deployments (useful after image updates).      |
| `make logs`         | Tails logs for frontend, backend, and mongo pods simultaneously.             |
| `make status`       | Shows the current status of pods and services in the `piscord` namespace.    |
| `make delete`       | Removes all deployed resources from the cluster (keeps the cluster running). |

## 🏗️ Architecture & Structure

This repository focuses on the **Infrastructure as Code (IaC)** aspect.

```text
.
├── k8s/
│   ├── backend/      # Backend Deployment & Service
│   ├── frontend/     # Frontend Deployment & Service
│   ├── mongo/      # MongoDB StatefulSet & Service
│   ├── namespace.yaml
│   └── ingress.yaml
├── Makefile          # Automation scripts
└── README.md         # Documentation
```

## 🔗 References

For the source code of the application services, please visit:

- [**Frontend Repository**](https://github.com/davmp/piscord-frontend)
- [**Backend Repository**](https://github.com/davmp/piscord-backend)
- [**Persistence Worker Repository**](https://github.com/davmp/piscord-worker)
