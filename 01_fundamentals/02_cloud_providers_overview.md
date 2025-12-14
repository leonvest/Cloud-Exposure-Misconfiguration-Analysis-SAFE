# Cloud Providers Overview (AWS vs Azure vs GCP)

This file explains how the three major cloud providers map to the same concepts.
The names differ, but the core ideas are very similar.

---

## Quick comparison table (concept mapping)

Compute (VMs):
- AWS: EC2
- Azure: Virtual Machines
- GCP: Compute Engine (GCE)

Virtual network:
- AWS: VPC
- Azure: VNet
- GCP: VPC (global by default)

Firewalling:
- AWS: Security Groups + NACLs
- Azure: Network Security Groups (NSGs)
- GCP: VPC Firewall Rules

Object storage:
- AWS: S3
- Azure: Blob Storage
- GCP: Cloud Storage

Identity / permissions:
- AWS: IAM (users/roles/policies)
- Azure: Entra ID (Azure AD) + RBAC (roles) + Managed Identities
- GCP: IAM (roles) + Service Accounts

Managed Kubernetes:
- AWS: EKS
- Azure: AKS
- GCP: GKE

Logs/Monitoring:
- AWS: CloudWatch + CloudTrail
- Azure: Monitor + Activity Log
- GCP: Cloud Logging + Cloud Audit Logs

---

## How providers differ (security-relevant differences)

### 1) Identity model and “default” workflows
- **AWS** often centers around IAM roles, policies, and short-lived credentials for workloads.
- **Azure** tightly integrates identity via Entra ID and role-based access control (RBAC).
- **GCP** uses IAM roles and service accounts extensively, often with strong organization policy controls.

Defensive note:
> Most cloud breaches escalate through identity permissions, not packet-level hacks.

---

### 2) Networking style
- **AWS VPC** is regional, and segmentation is typically done via subnets + route tables + security groups.
- **Azure VNet** is similar, but NSGs and Azure-native services often shape architecture strongly.
- **GCP VPC** is global by default; firewall rules apply at the VPC level with network tags/service accounts.

Defensive note:
> Always validate: “What is reachable from where?” (internet, VPC/VNet, peering, VPN, etc.)

---

### 3) Logging & auditing defaults
All providers can log critical events, but it must be enabled and reviewed:
- Who changed a firewall rule?
- Who made storage public?
- Who created new credentials?

Defensive note:
> If you don’t log control-plane actions, you lose the ability to explain incidents.

---

## Provider-agnostic security checklist (high level)

### Exposure control
- Minimize public endpoints
- Restrict firewall rules to necessary sources
- Use private endpoints where possible

### Identity control
- Least privilege IAM/RBAC
- Prefer short-lived credentials over static keys
- Protect privileged accounts with MFA and strong controls

### Blast radius reduction
- Segment networks
- Separate environments (dev/test/prod)
- Restrict lateral movement paths

### Monitoring
- Audit logs enabled (control plane)
- Alerts for risky changes (IAM, firewall, storage permissions)

---

## Key takeaway

> AWS, Azure, and GCP look different, but the same security principles apply:
> manage exposure, manage identity, and log everything that changes.
