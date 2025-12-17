# Cloud Fundamentals: What “Cloud” Actually Means

Cloud computing is a way to rent computing resources (servers, storage, networking)
from a provider instead of owning the hardware yourself. You still run operating systems,
applications, and databases — but the infrastructure is managed via **APIs** and
provider control panels.

This tutorial is defensive: it focuses on understanding **attack surface** and how to
reduce exposure. No exploitation steps are included.

---

## Core cloud building blocks

### Compute
Virtual machines (VMs) and managed runtimes that run your code.
- VM examples: AWS EC2, Azure Virtual Machines, Google Compute Engine (GCE)
- Managed runtimes: AWS Lambda, Azure Functions, Google Cloud Functions

### Storage
Ways to store files, objects, or blocks.
- Object storage: AWS S3, Azure Blob Storage, Google Cloud Storage
- Block storage: AWS EBS, Azure Managed Disks, GCP Persistent Disks

### Networking
Virtual networks, subnets, routing, firewalls, and load balancers.
- Virtual networks: AWS VPC, Azure VNet, GCP VPC
- Cloud firewalls: Security Groups / NSGs / Firewall Rules

### Identity and Access Management (IAM)
Controls who can do what in the cloud.
- AWS IAM, Azure Entra ID (Azure AD) + RBAC, GCP IAM

---

## What is “attack surface” in the cloud?

An attack surface is any place where an attacker can interact with your system.
In the cloud, the big difference is that **configuration itself is an interface**.

Common sources of cloud attack surface:
- Public IPs on VMs and services
- Overly permissive firewall rules
- Leaked credentials (keys/tokens)
- Misconfigured storage (public buckets)
- Over-privileged identities (IAM roles)
- Metadata endpoints reachable from workloads
- Weak segmentation between internal systems

Key idea:
> Cloud incidents are often caused by misconfiguration or excessive permissions,


---

## Cloud shared responsibility (important concept)

All major providers use a “shared responsibility model”:
- The provider secures the underlying physical infrastructure
- You secure your configuration, identities, OS/app, and data

Even if the cloud vendor is secure, your deployment can be insecure.

---

## Typical cloud exposure patterns (defensive view)

### 1) “Public by accident”
A service is reachable from the internet because:
- a firewall rule is too broad (0.0.0.0/0), or
- the service is bound to all interfaces, or
- a load balancer is public unintentionally

### 2) “Internal only… but reachable”
A service is not internet-facing, but becomes reachable due to:
- VPNs, bastions, jump hosts
- port forwarding / tunneling
- poor segmentation inside the cloud network

### 3) “Identity is the new perimeter”
If an attacker gets cloud credentials, they may not need network access at all.
They can call APIs to:
- list resources
- change firewall rules
- read storage
- create new access tokens (depending on permissions)

---

## Key takeaway

> Cloud security is mostly about **controlling exposure** (network + identity)
> and **reducing blast radius** if something goes wrong.
