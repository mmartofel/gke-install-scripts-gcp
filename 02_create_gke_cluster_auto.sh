
export CLUSTER_NAME=korniszon
export REGION=europe-central2

# gcloud config set project on-prem-project-337210

gcloud compute networks create default --subnet-mode=auto

gcloud container clusters create-auto $CLUSTER_NAME --region=$REGION

gcloud container clusters get-credentials $CLUSTER_NAME --region=$REGION

kubectl create deployment hello-server --image=us-docker.pkg.dev/google-samples/containers/gke/hello-app:1.0

kubectl expose deployment hello-server --type LoadBalancer --port 80 --target-port 8080

kubectl get pods

kubectl get service hello-server

