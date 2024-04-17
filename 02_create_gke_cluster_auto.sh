
export CLUSTER_NAME=korniszon
export REGION=europe-central2
export PROJECT=`gcloud config get project`


# Set current GCP project
gcloud config set project $PROJECT

# Create default network
gcloud compute networks create default --subnet-mode=auto

# Create cluster
gcloud container clusters create-auto $CLUSTER_NAME --region=$REGION

#Get cluster credentials
gcloud container clusters get-credentials $CLUSTER_NAME --region=$REGION

# Deploy example workload
kubectl create deployment hello-server --image=us-docker.pkg.dev/google-samples/containers/gke/hello-app:1.0 -n default
kubectl expose deployment hello-server --type LoadBalancer --port 80 --target-port 8080 -n default
# Check running pods
kubectl get pods -n default
# Get service configuration
kubectl get service hello-server -n default
