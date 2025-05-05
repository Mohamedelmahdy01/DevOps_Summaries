# Kubernetes (K8s) - Introduction

## What is Kubernetes?

Kubernetes (K8s) is an open-source platform for automating the deployment, scaling, and management of containerized applications. Initially developed by Google based on their experience running production workloads at scale, it is now maintained by the Cloud Native Computing Foundation (CNCF). Kubernetes is the de facto standard for container orchestration, enabling applications to run consistently across on-premises, public cloud, or hybrid environments. It provides:

- **Automated Container Deployment and Management**: Handles container lifecycle tasks like creation, scheduling, and deletion.
- **Scalability and High Availability**: Scales applications dynamically and ensures they remain available during failures.
- **Infrastructure Abstraction**: Hides underlying hardware or cloud provider complexities, allowing focus on application logic.
- **Declarative Configuration**: Uses YAML or JSON manifests to define desired application states, which Kubernetes enforces.

**Example**: A global e-commerce platform uses Kubernetes to manage thousands of containers, automatically scaling its checkout service during peak shopping hours and redistributing workloads if a server fails.

## Why Kubernetes Matters

### Industry Adoption
- **77%** of organizations are adopting cloud/container technologies (CNCF Annual Survey, 2023).
- Demand for Kubernetes skills grew **842%** in 5 years, outpacing other IT operations skills (Indeed, 2023).
- Supported by all major cloud providers (AWS EKS, Azure AKS, Google GKE) and on-premises platforms (Red Hat OpenShift, VMware Tanzu).
- Used by enterprises like Netflix, Spotify, and Goldman Sachs to power mission-critical applications.

### Key Benefits
1. **Production-Grade Hosting**: Supports enterprise-scale applications with features like auto-scaling, self-healing, and zero-downtime updates.
2. **Architecture Flexibility**: Accommodates monolithic apps, microservices, serverless workloads, and batch jobs.
3. **Resource Efficiency**: Optimizes CPU, memory, and storage by densely packing containers on nodes.
4. **Portability**: Ensures consistent behavior across different environments, reducing vendor lock-in.
5. **Rich Ecosystem**: Integrates with tools like Helm for package management, Prometheus for monitoring, and Istio for service mesh.

**Example**: A gaming company uses Kubernetes to deploy a multiplayer game backend, efficiently allocating resources during player surges and rolling out updates without interrupting gameplay.

## Core Concepts

### Container Orchestration
Kubernetes addresses critical production challenges for containerized applications:
- **Managing Multi-Container Applications**: Coordinates complex systems like web servers, databases, and caching layers.
- **Automatic Scaling**: Scales pods up or down based on metrics like CPU usage or custom application metrics.
- **High Availability and Fault Tolerance**: Redistributes workloads if nodes or pods fail.
- **Load Balancing**: Distributes traffic evenly across pods to ensure performance.
- **Seamless Updates and Rollbacks**: Performs rolling updates to minimize downtime and supports rollbacks if issues arise.

**Example**: A streaming service runs a microservices architecture with Kubernetes, where the recommendation engine, video encoder, and user authentication services are managed as separate pods, scaled independently based on demand.

### Kubernetes vs Alternatives
| Feature            | Docker Swarm       | Kubernetes         | Apache Mesos       |
|--------------------|--------------------|--------------------|--------------------|
| **Ease of Setup**  | Easy (simple CLI)  | Moderate (complex setup) | Hard (enterprise focus) |
| **Scalability**    | Basic (small clusters) | Excellent (large-scale) | Good (data-heavy workloads) |
| **Features**       | Limited (basic orchestration) | Extensive (full ecosystem) | Advanced (custom frameworks) |
| **Community**      | Declining          | Massive (CNCF-backed) | Niche (big data focus) |
| **Cloud Support**  | Limited            | Universal (AWS, Azure, GCP) | Strong (on-premises) |

**Why Choose Kubernetes?** Kubernetes offers the most comprehensive feature set and community support, making it ideal for production-grade applications, though it has a steeper learning curve than Docker Swarm.

## Kubernetes Architecture

### Cluster Components
- **Nodes**: Physical or virtual machines that run containers. Nodes are categorized as:
  - **Control Plane Nodes**: Host the control plane components.
  - **Worker Nodes**: Run application workloads (pods).
- **Cluster**: A collection of nodes working together, managed as a single system.
- **Control Plane**: The set of components that manages the cluster’s state and orchestrates workloads.

### Control Plane Components
- **API Server (kube-apiserver)**: The frontend for all cluster interactions, handling RESTful API requests from users and components.
- **etcd**: A distributed, highly available key-value store that holds all cluster data, such as pod configurations and states.
- **Scheduler (kube-scheduler)**: Assigns pods to nodes based on resource requirements, affinity rules, and constraints.
- **Controller Manager (kube-controller-manager)**: Runs controllers (e.g., ReplicaSet, Deployment) to maintain desired states.
- **Cloud Controller Manager** (optional): Integrates with cloud provider APIs for resources like load balancers.

### Node Components
- **Kubelet**: An agent on each node that communicates with the control plane and manages pod lifecycles.
- **Container Runtime**: Software (e.g., containerd, CRI-O) that runs containers.
- **Kube-Proxy**: Manages network rules on nodes to enable pod communication and load balancing.

**Example**: In a 10-node cluster, the control plane runs on 3 dedicated nodes for redundancy, while 7 worker nodes run application pods. If a worker node fails, the scheduler moves its pods to other nodes.

## How Kubernetes Works

### Declarative Model
Kubernetes operates on a declarative model:
- Users define the **desired state** in YAML or JSON manifests (e.g., number of pod replicas, container images).
- Kubernetes’ control plane continuously monitors the **current state** and reconciles it with the desired state.
- Actions like restarting failed pods or scaling replicas are automated.

**Example YAML for a Pod**:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
  labels:
    app: my-app
spec:
  containers:
  - name: my-container
    image: nginx:1.14.2
    ports:
    - containerPort: 80
```

This YAML creates a pod running an Nginx container. Applying it with `kubectl apply -f pod.yaml` instructs Kubernetes to ensure the pod exists.

### Key Objects
- **Pods**: The smallest deployable unit, typically containing one or more containers that share storage and network resources. Example: A pod with a web server and a logging sidecar.
- **Deployments**: Manage pod lifecycles, enabling rolling updates and rollbacks. Example: Update an app from v1 to v2 without downtime.
- **Services**: Provide a stable endpoint (IP/DNS) for accessing pods, supporting load balancing. Example: A `LoadBalancer` service exposes an app to the internet.
- **ReplicaSets**: Ensure a specified number of pod replicas are running. Usually managed by Deployments.
- **ConfigMaps/Secrets**: Store configuration data or sensitive information (e.g., API keys) for pods.
- **Ingress**: Manages external HTTP/HTTPS traffic, routing to services based on rules.

**Example**: A Deployment ensures 5 replicas of a web app pod are running. A Service load-balances traffic across them, and an Ingress routes `example.com` to the Service.

### Self-Healing
Kubernetes automatically:
- Restarts containers that crash.
- Reschedules pods if a node fails.
- Replaces pods that don’t meet health checks (e.g., liveness/readiness probes).

**Example**: A pod fails a liveness probe (e.g., HTTP endpoint returns 500). Kubernetes restarts the pod and, if persistent, reschedules it to a healthy node.

## Getting Started

### Basic Commands
```bash
# View cluster information
kubectl cluster-info

# List all nodes in the cluster
kubectl get nodes

# Deploy a pod with Nginx
kubectl run nginx --image=nginx

# List all pods
kubectl get pods

# Expose a pod as a service
kubectl expose pod nginx --port=80 --type=ClusterIP

# Scale a deployment
kubectl scale deployment nginx --replicas=3
```

### First Steps
1. **Install Tools**:
   - `kubectl`: Command-line tool for interacting with Kubernetes.
   - Minikube or Kind: Run a local Kubernetes cluster for learning.
2. **Deploy a Sample App**:
   - Create a pod or deployment with a container image (e.g., `nginx`).
   - Expose it as a service to access it locally.
3. **Explore**:
   - Check pod logs with `kubectl logs <pod-name>`.
   - Debug with `kubectl describe pod <pod-name>`.

**Example Workflow**:
```bash
# Start a local cluster
minikube start

# Deploy an application
kubectl create deployment my-app --image=nginx

# Expose it
kubectl expose deployment my-app --port=80 --type=NodePort

# Access it
minikube service my-app
```

### Learning Resources
- **Official Docs**: Kubernetes.io offers tutorials and reference guides.
- **Interactive Labs**: Try Katacoda or Play with Kubernetes for hands-on practice.
- **Courses**: CNCF’s “Kubernetes Fundamentals” (LFS258) or free YouTube tutorials.
- **Community**: Join CNCF Slack, Kubernetes forums, or local meetups.

## Advanced Topics
- **Networking**: Use Ingress for external traffic or Network Policies for pod isolation.
- **Storage**: Manage stateful apps with Persistent Volumes (PV) and Persistent Volume Claims (PVC).
- **Security**: Implement RBAC, Pod Security Policies, and Secrets management.
- **Monitoring**: Use Prometheus and Grafana for cluster and application metrics.
- **CI/CD**: Integrate with GitOps tools like ArgoCD or Flux for automated deployments.

**Example**: A company sets up an Ingress controller to route `api.example.com` to a backend service and uses Prometheus to monitor pod CPU usage, triggering alerts if thresholds are exceeded.

## Who Uses Kubernetes?
- **Developers**: Build and test cloud-native apps.
- **DevOps Engineers**: Automate deployments and manage CI/CD pipelines.
- **SysAdmins**: Maintain production clusters and ensure security.
- **Data Scientists**: Run distributed ML workloads with Kubeflow.
- **Enterprises**: Standardize infrastructure across hybrid clouds.

---


# Kubernetes Pods - Core Concepts

## What is a Pod?

A **Pod** is the smallest deployable unit in Kubernetes, encapsulating one or more containers that share resources and operate as a single entity. Pods are the foundational building blocks for running applications in a Kubernetes cluster, designed to execute a specific workload or service.

### Key Characteristics
- **Unique IP Address**: Each pod is assigned a cluster-unique IP address, enabling network communication.
- **Shared Resources**: Containers within a pod share:
  - **Network Namespace**: Containers can communicate with each other via `localhost` (e.g., port 8080).
  - **Storage Volumes**: Containers can access shared persistent or temporary storage.
  - **Lifecycle**: Containers are created, run, and terminated together.
- **Ephemeral Nature**: Pods are typically short-lived and managed by higher-level objects like Deployments or ReplicaSets for persistence.

**Example**: A pod running a web server (Nginx) and a logging agent (Fluentd) shares a network namespace, allowing the logging agent to collect logs from the web server via `localhost`.

## Pod Lifecycle

Pods progress through distinct phases, tracked by Kubernetes:
1. **Pending**: The pod has been accepted by the API server but is not yet running (e.g., containers are being pulled or scheduled).
2. **Running**: The pod is bound to a node, and all containers have been created and are running.
3. **Succeeded**: All containers in the pod have terminated successfully and will not be restarted.
4. **Failed**: At least one container has terminated with a failure (non-zero exit code), and the pod won’t restart unless configured to.
5. **Unknown**: The pod’s state cannot be determined, typically due to communication issues with the node.

**Example**: A pod in the `Pending` phase might be waiting for a container image to download. If a container crashes, the pod moves to `Failed` unless a restart policy is set.

### Restart Policies
- **Always** (default): Containers are restarted on failure (used by Deployments).
- **OnFailure**: Containers are restarted only if they fail.
- **Never**: Containers are not restarted, even on failure (used by Jobs).

**Example YAML with Restart Policy**:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  restartPolicy: OnFailure
  containers:
  - name: my-container
    image: busybox
    command: ["sh", "-c", "sleep 10 && exit 1"]
```
This pod runs a container that fails after 10 seconds and will be restarted due to the `OnFailure` policy.

## Single vs Multi-Container Pods

### Single Container Pods (Most Common)
The simplest and most common use case, where a pod runs one container for a single application or service.

**Example YAML**:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  namespace: default
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    ports:
    - containerPort: 80
```
This pod runs an Nginx web server, exposing port 80.

### Multi-Container Pods (Sidecar Pattern)
Multi-container pods are used when containers need tight coupling, such as sharing data or performing auxiliary tasks (e.g., logging, monitoring, or proxying). Common patterns include:
- **Sidecar**: A helper container supports the main application (e.g., log collection).
- **Adapter**: Transforms data for the main container (e.g., protocol conversion).
- **Ambassador**: Proxies external communication (e.g., database proxy).

**Example YAML**:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-app
spec:
  containers:
  - name: web-server
    image: nginx:1.25
    ports:
    - containerPort: 80
    volumeMounts:
    - name: logs
      mountPath: /var/log/nginx
  - name: log-processor
    image: fluentd:1.16
    volumeMounts:
    - name: logs
      mountPath: /logs
  volumes:
  - name: logs
    emptyDir: {}
```
This pod runs an Nginx server and a Fluentd container, sharing a volume for logs. Fluentd processes Nginx logs from the shared volume.

**Use Case**: A web application pod includes a main container (Node.js app) and a sidecar (Prometheus exporter) to collect and expose metrics.

## Creating Pods

### Imperative Approach (Quick Start)
Ideal for testing or learning, using `kubectl` commands to create pods directly.

**Example**:
```bash
kubectl run nginx --image=nginx:1.25 --port=80
```
This creates a pod named `nginx` running the latest Nginx image.

### Declarative Approach (Recommended for Production)
Define pods in YAML or JSON files and apply them with `kubectl`. This approach supports version control, reproducibility, and complex configurations.

**Steps**:
1. Create a file (e.g., `pod-definition.yaml`).
2. Apply it:
```bash
kubectl apply -f pod-definition.yaml
```

**Example YAML with Probes**:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-app
spec:
  containers:
  - name: my-app
    image: my-app:1.0
    livenessProbe:
      httpGet:
        path: /health
        port: 8080
      initialDelaySeconds: 15
      periodSeconds: 10
    readinessProbe:
      httpGet:
        path: /ready
        port: 8080
      initialDelaySeconds: 5
      periodSeconds: 5
```
This pod includes liveness and readiness probes to check the application’s health and readiness to serve traffic.

## Managing Pods

### Common Commands
| Command | Description |
|---------|-------------|
| `kubectl get pods` | List all pods in the current namespace |
| `kubectl get pods -A` | List pods across all namespaces |
| `kubectl describe pod <name>` | Show detailed pod information (events, status, etc.) |
| `kubectl logs <pod-name> [-c <container-name>]` | View logs for a container (specify container for multi-container pods) |
| `kubectl exec -it <pod-name> [-c <container-name>] -- /bin/bash` | Access a container’s shell |
| `kubectl delete pod <name>` | Delete a pod (recreated if managed by a Deployment) |
| `kubectl port-forward pod/<name> 8080:80` | Forward a local port to a pod’s port |

**Example**:
```bash
kubectl describe pod nginx
```
This displays events like scheduling, image pulling, or errors for the `nginx` pod.

### Monitoring Pods
- **Watch Status**: Monitor real-time changes:
  ```bash
  kubectl get pods -w
  ```
- **Detailed Output**: Include node and IP information:
  ```bash
  kubectl get pods -o wide
  ```
- **Resource Usage**: Use `kubectl top` (requires metrics server):
  ```bash
  kubectl top pod nginx
  ```

**Example**: A pod stuck in `Pending` might show in `kubectl describe` that it’s waiting for a node with sufficient CPU.

## Pod Networking

- **Cluster IP**: Each pod gets a unique IP address within the cluster, routable across nodes.
- **Shared Network Namespace**: Containers in a pod share the same network stack, allowing `localhost` communication.
- **Service Discovery**: Pods are accessed via Kubernetes Services or DNS (e.g., `my-service.my-namespace.svc.cluster.local`).
- **External Access**: Ingress or LoadBalancer services expose pods to the internet.

**Example**: Two containers in a pod communicate over `localhost:8080`. A Service routes external traffic to the pod’s IP, balancing across replicas.

## Practical Considerations

### When to Use Multi-Container Pods
Use multi-container pods when:
1. **Helper Containers**: A sidecar performs tasks like log processing, metrics collection, or data synchronization.
   - Example: A Prometheus exporter collects metrics from an application.
2. **Proxies/Adapters**: A container handles external communication or data transformation.
   - Example: An Envoy proxy manages API requests for a legacy app.
3. **Shared Volumes**: Containers need to read/write to the same storage.
   - Example: A web server writes logs to a volume that a log shipper reads.

### Best Practices
- **Single Responsibility**: Prefer one application container per pod unless sidecars are necessary.
- **Resource Limits**: Define CPU and memory requests/limits to prevent resource contention:
  ```yaml
  resources:
    requests:
      cpu: "100m"
      memory: "128Mi"
    limits:
      cpu: "500m"
      memory: "256Mi"
  ```
- **Health Checks**: Use liveness and readiness probes to ensure pod reliability.
- **Labels and Selectors**: Apply labels (e.g., `app=my-app`) for organization and service routing.
- **Avoid Manual Pod Management**: Use Deployments or StatefulSets for production to handle scaling and updates.
- **Restart Policy**: Choose `Always` for long-running apps, `Never` for one-off tasks, or `OnFailure` for retryable jobs.

**Example**: A pod with a liveness probe restarts if its `/health` endpoint fails, ensuring only healthy pods serve traffic.

## Demo: Deploying a Pod with Minikube

This demo walks through creating, inspecting, and deleting a pod using Minikube.

1. **Start Minikube Cluster**:
   ```bash
   minikube start
   ```

2. **Create Nginx Pod**:
   ```bash
   kubectl run nginx --image=nginx:1.25 --port=80
   ```

3. **Verify Pod Status**:
   ```bash
   kubectl get pods -o wide
   ```
   Output shows the pod’s IP, node, and status (e.g., `Running`).

4. **Access Pod Logs**:
   ```bash
   kubectl logs nginx
   ```
   Displays Nginx access or error logs.

5. **Expose Pod for Testing**:
   ```bash
   kubectl port-forward pod/nginx 8080:80
   ```
   Access the Nginx server at `http://localhost:8080`.

6. **Clean Up**:
   ```bash
   kubectl delete pod nginx
   minikube stop
   ```

### Declarative Alternative
Create a file `nginx-pod.yaml`:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    ports:
    - containerPort: 80
    resources:
      requests:
        cpu: "100m"
        memory: "128Mi"
      limits:
        cpu: "200m"
        memory: "256Mi"
```
Apply it:
```bash
kubectl apply -f nginx-pod.yaml
```

> **Note**: While `kubectl run` is convenient for learning, production environments should use declarative YAML files with `kubectl apply` for version control and reproducibility.

## Advanced Pod Concepts

### Init Containers
Run setup tasks before the main containers start (e.g., database initialization).
**Example**:
```yaml
spec:
  initContainers:
  - name: init-db
    image: busybox
    command: ["sh", "-c", "until nslookup db; do sleep 2; done;"]
  containers:
  - name: app
    image: my-app:1.0
```
The `init-db` container waits for a database to be available before the app starts.

### Pod Disruption Budgets (PDB)
Ensure a minimum number of pods remain available during maintenance or scaling.
**Example**:
```yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: my-app-pdb
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app: my-app
```
This ensures at least 2 `my-app` pods are always running.

### Pod Affinity/Anti-Affinity
Control pod placement (e.g., co-locate pods or spread them across nodes).
**Example**:
```yaml
spec:
  affinity:
    podAntiAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchLabels:
              app: my-app
          topologyKey: kubernetes.io/hostname
```
This spreads `my-app` pods across different nodes for redundancy.

### Taints and Tolerations
Restrict which pods can schedule on specific nodes.
**Example**:
```yaml
spec:
  tolerations:
  - key: "dedicated"
    operator: "Equal"
    value: "frontend"
    effect: "NoSchedule"
```
This pod can run on nodes tainted with `dedicated=frontend:NoSchedule`.

## Common Issues and Troubleshooting
- **CrashLoopBackOff**: Check logs (`kubectl logs`) for container errors or misconfigurations.
- **ImagePullBackOff**: Verify the image name/tag or registry access (`kubectl describe pod`).
- **Pending State**: Inspect scheduling issues (e.g., insufficient resources) with `kubectl describe pod`.
- **Pod Not Reachable**: Confirm Service configuration or network policies.

**Example**:
```bash
kubectl describe pod my-pod
```
Look for events like `FailedScheduling` due to resource constraints.

