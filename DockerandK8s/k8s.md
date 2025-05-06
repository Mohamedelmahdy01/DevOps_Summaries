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

## References

[Kubernetes Concepts](https://kubernetes.io/docs/concepts/)

[Pod Overview](https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/)

---



# YAML for Kubernetes

## What is YAML?

YAML (YAML Ain't Markup Language) is a human-readable data serialization format widely used for configuration files, data exchange, and defining Kubernetes objects. Its simplicity and clarity make it ideal for specifying complex configurations in a structured, intuitive way. In Kubernetes, YAML files define the desired state of resources like Pods, Deployments, and Services.

### Why YAML for Kubernetes?
- **Human-Readable**: Clear syntax reduces errors and improves maintainability.
- **Hierarchical Structure**: Supports nested configurations for complex objects.
- **Version Control**: YAML files can be stored in Git for tracking changes.
- **Interoperability**: Works across programming languages and tools.

### Comparison with Other Formats
| Format | Example | Pros | Cons |
|--------|---------|------|------|
| **XML** | `<server><name>east</name><ip>192.168.1.1</ip></server>` | Structured, widely supported | Verbose, complex |
| **JSON** | `{"server": {"name": "east", "ip": "192.168.1.1"}}` | Compact, machine-friendly | Less readable for humans |
| **YAML** | ```yaml<br>server:<br>  name: east<br>  ip: 192.168.1.1<br>``` | Readable, concise | Sensitive to indentation |

**Why YAML Wins**: YAML’s clean syntax and support for comments make it more developer-friendly than XML or JSON for Kubernetes manifests.

## Basic YAML Structures

### Key-Value Pairs
Represents simple properties with a key and value.
```yaml
fruit: apple
vegetable: carrot
drink: water
```
**Use Case**: Define basic metadata like a pod’s name or namespace.

### Lists/Arrays
Represents a collection of items, denoted by a hyphen (`-`).
```yaml
fruits:
  - apple
  - banana
  - orange
```
**Use Case**: List containers in a pod or ports in a service.

### Dictionaries (Maps)
Groups related key-value pairs under a single key.
```yaml
apple:
  calories: 95
  fat: 0.3
  carbs: 25
```
**Use Case**: Define container specifications (image, ports, resources).

## Advanced Structures

### List of Dictionaries
Combines lists and dictionaries for multiple objects with properties.
```yaml
fruits:
  - name: apple
    calories: 95
    fat: 0.3
  - name: banana
    calories: 105
    fat: 0.4
```
**Use Case**: Define multiple containers or volume mounts in a pod.

### Nested Structures
Supports deep hierarchies for complex configurations.
```yaml
employee:
  name: Jacob
  sex: male
  age: 30
  title: Systems Engineer
  projects:
    - automation
    - support
  payslips:
    - month: June
      wage: 4000
    - month: July
       wage: 4500
```
**Use Case**: Define a pod with multiple containers, volumes, and probes.

### Multi-line Strings
Preserves line breaks for long text, using `|` or `>`.
```yaml
description: |
  This is a multi-line
  string that preserves
  line breaks.
code: >
  Folded multi-line string
  treated as a single line.
```
**Use Case**: Embed scripts or configuration files in a ConfigMap.

## YAML Syntax Rules

1. **Indentation**:
   - Use **2 spaces** (never tabs) for indentation.
   - Maintain consistent indentation for items at the same level.
   ```yaml
   # Correct
   containers:
     - name: nginx
       image: nginx:latest
   # Wrong
   containers:
     - name: nginx
         image: nginx:latest  # Inconsistent indentation
   ```

2. **Key-Value Separation**:
   - Include a space after the colon (`: `).
   ```yaml
   # Correct
   fruit: apple
   # Wrong
   fruit:apple  # No space after colon
   ```

3. **Comments**:
   - Use `#` for comments, ignored by parsers.
   ```yaml
   # This is a comment
   fruit: apple  # Inline comment
   ```

4. **Lists**:
   - Use hyphens (`-`) for list items, properly aligned.
   ```yaml
   # Correct
   ports:
     - containerPort: 80
     - containerPort: 443
   # Wrong
   ports:
   - containerPort: 80
    - containerPort: 443  # Incorrect nesting
   ```

5. **Anchors and Aliases**:
   - Reuse configurations with `&` (anchor) and `*` (alias).
   ```yaml
   defaults: &defaults
     memory: 512Mi
     cpu: 500m
   container:
     <<: *defaults
     image: nginx
   ```
   **Use Case**: Apply common resource limits to multiple containers.

6. **Booleans and Nulls**:
   - Use `true`, `false`, or `null` (case-sensitive).
   ```yaml
   enabled: true
   disabled: false
   empty: null
   ```

## When to Use Different Structures

| Scenario | Structure | Example |
|----------|-----------|---------|
| Single property | Key-value | `name: nginx-pod` |
| Multiple options | List | `ports: [80, 443]` |
| Object properties | Dictionary | `resources: {cpu: 500m, memory: 512Mi}` |
| Multiple objects | List of dictionaries | `containers: [{name: nginx, image: nginx}, {name: sidecar, image: fluentd}]` |
| Complex hierarchy | Nested structure | `spec: {template: {metadata: {labels: {app: web}}}}` |

## Kubernetes YAML Essentials

Kubernetes YAML files typically include four top-level fields:
- **apiVersion**: The API version of the resource (e.g., `v1`, `apps/v1`).
- **kind**: The type of resource (e.g., `Pod`, `Deployment`, `Service`).
- **metadata**: Information like `name`, `namespace`, and `labels`.
- **spec**: The desired state of the resource (e.g., containers, replicas).

### Basic Pod Definition
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  namespace: default
  labels:
    app: nginx
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
        cpu: "500m"
        memory: "256Mi"
```
**Purpose**: Defines a single pod running an Nginx container with resource limits.

### Deployment with Replicas
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment
  namespace: default
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: nginx
        image: nginx:1.25
        ports:
        - containerPort: 80
        livenessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 15
          periodSeconds: 10
```
**Purpose**: Manages a set of 3 Nginx pods with health checks and automatic scaling.

### Service Definition
```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-service
spec:
  selector:
    app: web
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80
  type: ClusterIP
```
**Purpose**: Exposes the `web` deployment as a stable internal endpoint.

### ConfigMap for Application Configuration
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  database_url: mysql://user:pass@db:3306/app
  log_level: debug
```
**Purpose**: Stores configuration data for an application, injectable via environment variables or volumes.

## Advanced Kubernetes YAML Examples

### Multi-Container Pod with Sidecar
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
**Purpose**: Runs an Nginx server with a Fluentd sidecar for log processing, sharing a volume.

### StatefulSet for Database
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql
spec:
  serviceName: mysql
  replicas: 3
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:8.0
        env:
        - name: MYSQL_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: mysql-secret
              key: password
        volumeMounts:
        - name: data
          mountPath: /var/lib/mysql
  volumeClaimTemplates:
  - metadata:
      name: data
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 10Gi
```
**Purpose**: Manages a stateful MySQL cluster with persistent storage and stable network identities.

## Common Mistakes to Avoid

1. **Inconsistent Indentation**:
   ```yaml
   # Wrong
   containers:
   - name: nginx
       image: nginx:latest  # Extra indentation
     ports:
       - containerPort: 80
   ```
   **Fix**: Use 2 spaces consistently.

2. **Missing or Incorrect Colons**:
   ```yaml
   # Wrong
   metadata
     name nginx-pod  # Missing colon
   ```
   **Fix**: Ensure `key: value` format.

3. **Using Tabs Instead of Spaces**:
   - Tabs cause parsing errors. Use spaces only.

4. **Incorrect List Syntax**:
   ```yaml
   # Wrong
   ports: - containerPort: 80  # Missing newline
   ```
   **Fix**:
   ```yaml
   ports:
     - containerPort: 80
   ```

5. **Invalid API Version or Kind**:
   ```yaml
   # Wrong
   apiVersion: v2  # Invalid version
   kind: Pods  # Incorrect kind
   ```
   **Fix**: Check valid `apiVersion` (e.g., `v1`, `apps/v1`) and `kind` (e.g., `Pod`, `Deployment`) in Kubernetes docs.

6. **Missing Required Fields**:
   ```yaml
   # Wrong
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: web
   # Missing spec
   ```
   **Fix**: Include all required fields (`metadata`, `spec`, etc.).

## Validating YAML Files

- **Online Validators**: Use tools like `yaml-lint` or online YAML validators to check syntax.
- **Kubernetes Dry Run**:
  ```bash
  kubectl apply --dry-run=client -f file.yaml
  ```
  Validates the YAML and checks for Kubernetes-specific errors without applying changes.
- **Kubeval**: A CLI tool to validate Kubernetes YAML against API schemas.
  ```bash
  kubeval file.yaml
  ```

## Practice Exercises

### Exercise 1: Basic Key-Value
Create a ConfigMap for application settings.
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-settings
data:
  environment: production
  log_level: info
  max_connections: "100"
```

### Exercise 2: List of Items
Define a Service with multiple ports.
```yaml
apiVersion: v1
kind: Service
metadata:
  name: multi-port-service
spec:
  selector:
    app: my-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
  - protocol: TCP
    port: 443
    targetPort: 8443
  type: ClusterIP
```

### Exercise 3: Complex Structure
Create a Deployment with multiple containers and environment variables.
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: complex-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: complex
  template:
    metadata:
      labels:
        app: complex
    spec:
      containers:
      - name: main-app
        image: my-app:1.0
        env:
        - name: DB_HOST
          value: mysql-service
        - name: API_KEY
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: api-key
        ports:
        - containerPort: 8080
      - name: sidecar
        image: prometheus-exporter:1.0
        ports:
        - containerPort: 9100
```

### Exercise 4: Nested Structure with Volumes
Define a Pod with a shared volume and init container.
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: init-pod
spec:
  initContainers:
  - name: init-data
    image: busybox
    command: ["sh", "-c", "echo 'data' > /data/init.txt"]
    volumeMounts:
    - name: shared-data
      mountPath: /data
  containers:
  - name: main
    image: nginx:1.25
    volumeMounts:
    - name: shared-data
      mountPath: /usr/share/nginx/html
  volumes:
  - name: shared-data
    emptyDir: {}
```

## Best Practices

1. **Use Consistent Formatting**: Adopt a standard (e.g., 2-space indentation, lowercase keys).
2. **Validate Before Applying**: Always run `kubectl apply --dry-run=client`.
3. **Version Control YAML**: Store manifests in Git for tracking and collaboration.
4. **Use Meaningful Names and Labels**: Include descriptive `metadata.name` and `labels` for clarity.
5. **Modularize Configurations**: Split large YAML files into smaller ones (e.g., one per resource type).
6. **Document with Comments**: Add comments to explain complex sections.
7. **Leverage Tools**:
   - **Helm**: Package and manage YAML templates.
   - **Kustomize**: Customize YAML for different environments.
   - **yq**: Query and modify YAML files programmatically.

## Tools for Working with YAML

- **Editors**: VS Code with YAML extension, IntelliJ, or Vim with YAML plugins.
- **Validators**: `yaml-lint`, `kubeval`, or online tools like YAML Validator.
- **Generators**: `kubectl create` or `helm create` to scaffold YAML.
- **Parsers**: `yq` or `jq` for scripting YAML modifications.

## References
- [Kubernetes Documentation](https://kubernetes.io/docs/concepts/)
- [YAML Specification](https://yaml.org/)

---

# Kubernetes Workload Objects: Pods, ReplicaSets & Deployments

This document provides a comprehensive overview of fundamental Kubernetes workload objects: Pods, ReplicaSets, and Deployments. These objects are essential for deploying and managing applications in Kubernetes, enabling scalability, self-healing, and declarative lifecycle management. Insights from practical labs and best practices are integrated to ensure a production-ready understanding.

## Pods - The Basic Building Block

### Key Characteristics
- **Smallest Deployable Unit**: A Pod is the smallest manageable unit in Kubernetes.
- **Encapsulates Containers**: Hosts one or more tightly coupled containers sharing resources.
- **Shared Resources**:
  - **Network Namespace**: Containers share the same IP and port space, communicating via `localhost`.
  - **Storage Volumes**: Containers share data through mounted volumes.
  - **Lifecycle**: Containers are co-located on the same node, co-scheduled, and created/destroyed together.
- **Unique IP Address**: Each Pod gets a cluster-unique IP for network communication.
- **Ephemeral**: Pods are short-lived and lost if their node fails, requiring controllers for persistence.

**Example Use Case**: A Pod running a web server (Nginx) and a sidecar (Fluentd) for log aggregation, sharing a volume for log data.

### Pod Definition Example
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  namespace: default
  labels:
    app: myapp
spec:
  containers:
  - name: nginx-container
    image: nginx:1.25
    ports:
    - containerPort: 80
    resources:
      requests:
        cpu: "100m"
        memory: "128Mi"
      limits:
        cpu: "500m"
        memory: "256Mi"
```
**Purpose**: Defines a single-container Pod running Nginx with resource constraints.

### Multi-Container Pod Patterns
Multi-container Pods are used for tightly coupled tasks. Common patterns include:
- **Sidecar**: Assists the main container (e.g., Fluentd for logging, Istio proxy for service mesh).
- **Adapter**: Modifies the main container’s interface/output (e.g., protocol conversion).
- **Ambassador**: Proxies external communication (e.g., database proxy).

**Example YAML**:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: webapp-with-sidecar
  labels:
    app: mywebapp
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
**Purpose**: Runs Nginx with a Fluentd sidecar for log processing. The `READY` column in `kubectl get pods` shows `2/2` if both containers are ready, or `1/2` if one is not.

### Managing Pods
- **Direct Creation**: Avoid in production due to lack of self-healing or scaling.
- **Controllers**: Use Deployments, StatefulSets, or Jobs for production.
- **Imperative Creation (Testing)**:
  ```bash
  kubectl run nginx-pod --image=nginx:1.25 --restart=Never
  ```
  **Note**: Since Kubernetes 1.18, `kubectl run` creates a Pod by default (not a Deployment) when `--restart=Never` is used. To generate a Pod YAML:
  ```bash
  kubectl run my-pod --image=busybox:1.36 --dry-run=client -o yaml --command -- sleep 3600 > my-pod.yaml
  kubectl apply -f my-pod.yaml
  ```

**Key Commands**:
- `kubectl get pods`: List Pods.
- `kubectl get pods -o wide`: Show node and IP details.
- `kubectl describe pod <pod-name>`: View configuration, status, and events.
- `kubectl logs <pod-name> [-c <container-name>]`: View logs (specify container for multi-container Pods).
- `kubectl delete pod <pod-name>`: Delete a Pod (recreated if managed by a controller).
- `kubectl edit pod <pod-name>`: Edit live Pod (avoid for controller-managed Pods).

## ReplicaSets - Ensuring Pod Availability

### Purpose
- **Maintains Desired Replicas**: Ensures a specified number of Pod replicas are running.
- **Self-Healing**: Replaces failed or deleted Pods.
- **Scaling**: Adjusts Pod count via `replicas`.
- **Modern Replacement**: Succeeds ReplicationController with set-based selectors.

**Example Use Case**: A ReplicaSet ensures 3 frontend Pods are always running, recreating any that fail.

### Key Features
- **Pod Template**: `spec.template` defines the Pod blueprint.
- **Label Selectors**: Manages Pods matching `spec.selector`.
- **Selector Matching**: `spec.selector.matchLabels` must match `spec.template.metadata.labels`.
- **Scaling**: Modify `replicas` to scale up/down.

### ReplicaSet Definition
```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend-rs
  labels:
    app: myapp-rs
    tier: frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      tier: frontend-pod
  template:
    metadata:
      labels:
        tier: frontend-pod
        app: myapp
    spec:
      containers:
      - name: nginx-container
        image: nginx:1.25
        ports:
        - containerPort: 80
```
**Purpose**: Maintains 3 Nginx Pods, ensuring the count matches `replicas`.

### How ReplicaSets Work
- **Monitoring**: Tracks Pods matching the selector.
- **Reconciliation**: Creates new Pods if count is low; terminates excess Pods if count is high.
- **Behavior**: If a manual Pod matches the selector and exceeds `replicas`, it may be terminated.

**Key Commands**:
- `kubectl get rs`: List ReplicaSets.
- `kubectl describe rs <replicaset-name>`: View details and events.
- `kubectl scale rs <replicaset-name> --replicas=5`: Scale to 5 Pods.
- `kubectl delete rs <replicaset-name>`: Delete ReplicaSet and its Pods.

## Deployments - Managing ReplicaSets and Application Updates

### Purpose
- **Declarative Lifecycle Management**: Manages updates, rollbacks, and scaling.
- **Manages ReplicaSets**: Creates/updates ReplicaSets to achieve desired state.
- **Production Standard**: Ideal for stateless applications like web servers or APIs.

### Key Features
- **Rolling Updates**: Gradually replaces old Pods with new ones, minimizing downtime.
- **Rollbacks**: Reverts to previous versions if updates fail.
- **Revision History**: Tracks changes for auditing/rollbacks.
- **Pause/Resume**: Batches changes before applying.
- **Update Strategies**:
  - **RollingUpdate**: Default, ensures availability during updates.
  - **Recreate**: Terminates all Pods before creating new ones, causing downtime.

**Example Use Case**: A Deployment updates a web app from Nginx 1.25 to 1.26 with zero downtime, rolling back if the new version fails.

### Deployment Definition
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deployment
  labels:
    app: web
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
      maxSurge: 1
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: nginx-container
        image: nginx:1.25
        ports:
        - containerPort: 80
        resources:
          requests:
            cpu: "100m"
            memory: "128Mi"
          limits:
            cpu: "500m"
            memory: "256Mi"
```
**Purpose**: Manages 3 Nginx Pods with rolling updates, ensuring minimal disruption.

### How Deployments Orchestrate Updates
- **New ReplicaSet**: Each `spec.template` change creates a new ReplicaSet.
- **Rolling Update**:
  1. Scales up new ReplicaSet per `maxSurge`.
  2. Scales down old ReplicaSet per `maxUnavailable`.
  3. Continues until old ReplicaSet has 0 Pods.
- **Rollback**: Reverts to a previous ReplicaSet.
- **Revision Tracking**: Retains old ReplicaSets (default `revisionHistoryLimit: 10`).

**Key Commands**:
- `kubectl set image deployment/web-deployment nginx-container=nginx:1.26`: Update image.
- `kubectl rollout status deployment/web-deployment`: Monitor rollout.
- `kubectl rollout history deployment/web-deployment`: View revisions.
- `kubectl rollout undo deployment/web-deployment`: Roll back to previous revision.
- `kubectl rollout pause/resume deployment/web-deployment`: Pause/resume rollout.

## Understanding the Hierarchy & Evolution

- **Pods**: Basic units, ephemeral without controllers.
- **ReplicationController (Legacy)**: Ensured replicas with equality-based selectors; replaced by ReplicaSets.
- **ReplicaSets**: Manage replicas with set-based selectors; limited for updates.
- **Deployments**: Manage ReplicaSets for declarative updates and rollbacks.

**Hierarchy**: Deployments → ReplicaSets → Pods. Deployments are the primary choice for stateless apps.

## Key Commands Comparison

| Operation              | Pods (`pod`, `po`)           | ReplicaSets (`rs`)             | Deployments (`deploy`)              |
|------------------------|------------------------------|--------------------------------|-------------------------------------|
| Create from file       | `kubectl create -f <file>`   | `kubectl create -f <file>`     | `kubectl create -f <file>`          |
| Create (imperative)    | `kubectl run <name> --image --restart=Never` | (Use Deployment)   | `kubectl create deployment <name> --image` |
| List                   | `kubectl get pods`           | `kubectl get rs`               | `kubectl get deploy`                |
| List (all related)     | `kubectl get all`            | `kubectl get all`              | `kubectl get all --selector <label>` |
| Describe (details)     | `kubectl describe pod <name>`| `kubectl describe rs <name>`   | `kubectl describe deploy <name>`    |
| View Logs              | `kubectl logs <pod_name> [-c <container>]` | N/A (per-Pod)  | N/A (per-Pod)         |
| Delete                 | `kubectl delete pod <name>`  | `kubectl delete rs <name>`     | `kubectl delete deploy <name>`      |
| Edit live object       | `kubectl edit pod <name>`    | `kubectl edit rs <name>`       | `kubectl edit deploy <name>`        |
| Apply from file        | `kubectl apply -f <file>`    | `kubectl apply -f <file>`      | `kubectl apply -f <file>` (preferred) |
| Scale                  | N/A                          | `kubectl scale rs <name> --replicas=<#>` | `kubectl scale deploy <name> --replicas=<#>` |
| Update Image           | Manual recreation            | Edit template (complex)        | `kubectl set image deploy/<name> <container>=<new_image>` |
| View Rollout Status    | N/A                          | N/A                            | `kubectl rollout status deploy/<name>` |
| View Rollout History   | N/A                          | N/A                            | `kubectl rollout history deploy/<name>` |
| Rollback Update        | N/A                          | N/A                            | `kubectl rollout undo deploy/<name> [--to-revision=<#>]` |
| Pause/Resume Rollout   | N/A                          | N/A                            | `kubectl rollout pause/resume deploy/<name>` |
| Explain Fields         | `kubectl explain pod.spec`   | `kubectl explain replicaset.spec` | `kubectl explain deployment.spec` |

**Note on `kubectl apply` vs `create`/`replace`**:
- `kubectl create -f`: Creates resources; fails if they exist.
- `kubectl replace -f`: Overwrites resources; may not remove omitted fields.
- `kubectl apply -f`: Merges changes declaratively, ideal for GitOps.

## When to Use Each

### Pods
- **Testing/Debugging**: Quick container tests.
- **One-Off Tasks**: Short-lived tasks (prefer Jobs/CronJobs).
- **Learning**: Understand Pod mechanics.
- **Avoid in Production**: Lack self-healing and updates.

### ReplicaSets
- **Simple Replication**: Stable Pod counts without updates (rare).
- **Learning**: Understand controller mechanics.
- **Typically Managed by Deployments**: Rarely used directly.

### Deployments
- **Production Stateless Apps**: Web servers, APIs, microservices.
- **Rolling Updates/Rollbacks**: Zero-downtime updates and reversions.
- **Declarative Management**: Define desired state.

## Best Practices

1. **Use Deployments**: Prefer Deployments for stateless apps; avoid raw Pods/ReplicaSets.
2. **Consistent Labels**: Ensure `spec.selector.matchLabels` matches `spec.template.metadata.labels`.
3. **Resource Limits**:
   ```yaml
   resources:
     requests:
       cpu: "100m"
       memory: "128Mi"
     limits:
       cpu: "500m"
       memory: "256Mi"
   ```
4. **Health Probes**:
   - **Liveness**: Restart unhealthy containers.
   - **Readiness**: Prevent traffic to unready Pods.
5. **Pod Disruption Budgets (PDB)**:
   ```yaml
   apiVersion: policy/v1
   kind: PodDisruptionBudget
   metadata:
     name: web-pdb
   spec:
     minAvailable: 2
     selector:
       matchLabels:
         app: web
   ```
6. **Anti-Affinity**:
   ```yaml
   spec:
     affinity:
       podAntiAffinity:
         preferredDuringSchedulingIgnoredDuringExecution:
         - weight: 100
           podAffinityTerm:
             labelSelector:
               matchLabels:
                 app: web
             topologyKey: kubernetes.io/hostname
   ```
7. **Declarative Config**: Use YAML with `kubectl apply -f` and GitOps.
8. **Specific Image Tags**: Use `nginx:1.25`, not `latest`.
9. **Secrets/ConfigMaps**: Store sensitive/config data externally.
10. **Revision History Limit**: Set `revisionHistoryLimit: 5` to save etcd space while retaining rollback capability.

## Troubleshooting Common Issues

1. **Pod Issues**:
   - **Pending**: Check `kubectl describe pod` for scheduling issues (e.g., resource constraints, taints).
   - **ImagePullBackOff**: Verify image name/tag, registry access, or `imagePullSecrets`.
   - **CrashLoopBackOff**: Inspect `kubectl logs` (use `-p` for previous logs if restarted).
   - **READY 0/1 or 1/2**: Check readiness probe failures in logs or `describe`.
   - **Example**:
     ```bash
     kubectl describe pod myapp-pod
     kubectl logs myapp-pod -c nginx-container
     ```

2. **ReplicaSet Issues**:
   - **Selector Mismatch**: Ensure `spec.selector` matches Pod template labels.
   - **Example**:
     ```bash
     kubectl describe rs frontend-rs
     ```

3. **Deployment Issues**:
   - **Rollout Stuck**: Check `kubectl rollout status` and `describe deploy`.
   - **Rollback Needed**: Use `kubectl rollout undo`.
   - **Example**:
     ```bash
     kubectl rollout status deploy/web-deployment
     kubectl rollout history deploy/web-deployment
     ```

4. **General Debugging**:
   - **Events**: `kubectl get events --sort-by='.lastTimestamp'`
   - **Nodes**: `kubectl describe node <node-name>` for taints or resource issues.
   - **YAML Validation**: `kubectl apply --dry-run=client -f file.yaml`
   - **Explain**: `kubectl explain deployment.spec.strategy`

5. **Common Errors**:
   - **API Version**: Use `apps/v1` for ReplicaSets/Deployments, not `v1`.
   - **Case Sensitivity**: `kind: Deployment`, not `deployment`.
   - **Resource Quotas**: Check namespace quotas in `describe pod` events.
   - **Network Policies**: Ensure image pulls and Pod communication are not blocked.

## Hands-on Lab Scenarios and Key Takeaways

Lab exercises reinforce practical skills:

1. **Pod Management**:
   - Create Pods via YAML or `kubectl run --restart=Never`.
   - Inspect with `kubectl get pods -o wide`, `describe pod`, and `logs`.
   - Troubleshoot `ImagePullBackOff` (wrong image), `CrashLoopBackOff` (app errors), or `Pending` (scheduling issues).
   - Generate YAML: `kubectl run --dry-run=client -o yaml`.
   - Delete Pods and observe recreation by controllers.

2. **ReplicaSet Management**:
   - Create ReplicaSets with correct `apiVersion: apps/v1`.
   - Verify selector/template label alignment.
   - Test self-healing by deleting Pods.
   - Scale with `kubectl scale rs`.
   - Troubleshoot selector mismatches or `apiVersion` errors.

3. **Deployment Lifecycle**:
   - Create Deployments via YAML or `kubectl create deployment`.
   - Observe hierarchy with `kubectl get all`.
   - Update images via `kubectl set image` or `apply -f`.
   - Monitor rollouts with `kubectl rollout status`.
   - Roll back with `kubectl rollout undo`.
   - Test `RollingUpdate` vs `Recreate` strategies using a script (e.g., `while true; do curl <service>; sleep 1; done`).

**Takeaways**:
- Pods are ephemeral; use controllers for production.
- Deployments simplify updates/rollbacks.
- Events in `kubectl describe` are critical for debugging.
- Declarative YAML with `kubectl apply` is the standard.

## Practical Example: Web Application Deployment (Enhanced)

This Deployment incorporates best practices for a production-ready Nginx web server.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app-deployment
  namespace: default
  labels:
    app: web-app
    environment: production
spec:
  replicas: 3
  revisionHistoryLimit: 5
  selector:
    matchLabels:
      app: web-app
      tier: frontend
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
      maxSurge: 1
  template:
    metadata:
      labels:
        app: web-app
        tier: frontend
        version: "1.25"
    spec:
      terminationGracePeriodSeconds: 30
      containers:
      - name: nginx-server
        image: nginx:1.25
        ports:
        - containerPort: 80
          name: http
        env:
        - name: NGINX_HOST
          value: "example.com"
        - name: APP_ENV
          valueFrom:
            configMapKeyRef:
              name: web-config
              key: environment
        resources:
          requests:
            cpu: "100m"
            memory: "128Mi"
          limits:
            cpu: "250m"
            memory: "256Mi"
        livenessProbe:
          httpGet:
            path: /
            port: http
          initialDelaySeconds: 15
          periodSeconds: 20
          timeoutSeconds: 5
          failureThreshold: 3
        readinessProbe:
          httpGet:
            path: /
            port: http
          initialDelaySeconds: 5
          periodSeconds: 10
          timeoutSeconds: 5
          failureThreshold: 3
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - weight: 100
            podAffinityTerm:
              labelSelector:
                matchLabels:
                  app: web-app
              topologyKey: kubernetes.io/hostname
```
**Complementary ConfigMap**:
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: web-config
  namespace: default
data:
  environment: production
```

**Complementary Service**:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-app-service
  namespace: default
spec:
  selector:
    app: web-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: http
  type: ClusterIP
```

**Apply and Verify**:
```bash
kubectl apply -f deployment.yaml
kubectl apply -f configmap.yaml
kubectl apply -f service.yaml
kubectl rollout status deployment/web-app-deployment
kubectl get pods -l app=web-app -o wide
kubectl describe svc web-app-service
```

**Test Update**:
```bash
kubectl set image deployment/web-app-deployment nginx-server=nginx:1.26
kubectl rollout status deployment/web-app-deployment
kubectl rollout history deployment/web-app-deployment
```

**Features**:
- Specific image tag (`nginx:1.25`).
- Resource limits/requests.
- Liveness/readiness probes.
- Anti-affinity for high availability.
- ConfigMap for configuration.
- Service for stable endpoint.
- Controlled rollout with `revisionHistoryLimit: 5`.

