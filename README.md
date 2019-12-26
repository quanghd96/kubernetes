# Kubernetes

## Build client image

```
    cd client
    yarn build
    docker build -t client .
```

## Build server image

```
    cd server
    docker build -t server .
```

## Create pod

```
    kubectl create -f frontend-pod-1.yaml
    kubectl create -f frontend-pod-2.yaml
    kubectl create -f backend-pod-1.yaml
    kubectl create -f backend-pod-2.yaml
    kubectl create -f service-frontend-lb.yaml
    kubectl create -f service-backend-lb.yaml
```

## Create deployment

```
    kubectl create -f frontend-deployment.yaml
    kubectl create -f backend-deployment.yaml
```
