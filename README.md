# Next.js + Docker + GHCR + Minikube

A minimal Next.js app containerized with Docker, built & pushed via GitHub Actions to GHCR, and deployed on Kubernetes (Minikube).

## Prerequisites
- Node.js 18/20 (for local dev)
- Docker
- GitHub account (public repo)
- Minikube + kubectl

## Local Development
```bash
npm install
npm run dev
# visit http://localhost:3000
