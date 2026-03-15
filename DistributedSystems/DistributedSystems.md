# Introduction to Distributed Systems

## What Are Distributed Systems?

Distributed systems consist of multiple independent computers (nodes) that communicate over a network to appear as a single coherent system to users. Computation and/or state are spread across separate machines, introducing challenges not present in single-machine systems.

Key distinction:  
- **Computation-only distribution** (e.g., multi-core or multi-machine processing without shared state).  
- **State distribution** (nodes maintain and coordinate shared state over unreliable networks).

## Why Use Distributed Systems?

Single-machine applications face limitations when scaling:

- **Single-threaded processing on one core**: A server handling client requests (e.g., a chat application broadcasting messages) processes one task at a time, blocking others during I/O operations.
- **Multi-threading on single core**: Threads share CPU time slices, but blocking operations (e.g., network I/O) still idle the CPU.
- **Multi-core solutions**: Distribute threads across cores, but shared memory allows fast, reliable communication with atomicity guarantees.

Distributing across machines addresses:

1. **Scalability**  
   - Horizontal scaling: Add nodes to handle more load (e.g., more clients or data).  
   - Distribute read/write load across replicas.

2. **Fault Tolerance**  
   - Replicate state across nodes; if one fails, others continue.  
   - Achieve high availability despite hardware/network failures.

3. **Low Latency**  
   - Place replicas geographically closer to users (e.g., servers in multiple regions to reduce round-trip time limited by speed of light).

4. **Other Reasons**  
   - Regulatory compliance (data residency laws).  
   - Organizational scaling (independent teams managing services).

Trade-offs: Network introduces latency, partitions, packet loss/corruption, and loss of shared memory guarantees.

## Stateful vs. Stateless Services

- **Stateless**: No persistent state on the service node (e.g., web servers where state is external, like in a database). Easier to scale horizontally.
- **Stateful**: Nodes hold and manage shared state (e.g., distributed databases or caches). Requires coordination for consistency.

Common patterns for stateful systems:
- **Replication**: Copies of state on multiple nodes (for availability/fault tolerance).
  - Strong consistency: All replicas identical at all times.
  - Eventual consistency: Replicas converge over time; temporary inconsistencies possible.
- **Sharding/Partitioning**: Split state across nodes (for scalability); each node owns a subset.

## Challenges in Distributed Systems: Failures

Networks are unreliable:
- Message loss, delay, duplication, or corruption.
- Node crashes (stop failures) or Byzantine behavior (arbitrary/malicious).
- Network partitions: Nodes split into groups unable to communicate.

Types of node failures:
- **Crash/Stop**: Node halts and stays down.
- **Byzantine**: Node behaves arbitrarily (e.g., sends conflicting messages).

Real-world examples: Power outages, hardware failure, network cable cuts, fires, or natural disasters.

**Network Partitions**: Subgroups of nodes can communicate internally but not across groups. Each subgroup may assume the other is down, leading to split-brain scenarios.

Not all failures need full tolerance (costly); systems define acceptable failure models based on business requirements.

## Consensus and Agreement Problems

Core challenge: Nodes must agree on state despite failures.

- **Two Generals Problem** (simplified non-Byzantine case):  
  Two armies must coordinate attack via unreliable messengers. No guaranteed delivery means infinite acknowledgments needed for certainty. Impossible to achieve 100% agreement; practical systems accept probabilistic guarantees or bounded risk.

- **Byzantine Generals Problem**:  
  Generals (nodes) must agree on a plan, but some are traitors sending conflicting messages. Requires algorithms tolerating up to *f* faulty nodes in *3f+1* total nodes.

Solutions focus on non-Byzantine (crash-fault) tolerance for most systems:
- **Paxos**: Classic algorithm for consensus; ensures safety (single value chosen) and liveness (progress).
- **Raft**: More understandable alternative to Paxos; uses leader election, log replication. Widely used (e.g., etcd, Consul).

Future topics: Detailed Paxos/Raft algorithms, real-world implementations (e.g., etcd-based systems).

This introduction sets the foundation for building reliable, scalable distributed systems while understanding inherent trade-offs (e.g., CAP theorem implications).