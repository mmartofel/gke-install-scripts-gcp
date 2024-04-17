
export PROJECT=`gcloud config get project`

export CLUSTER_NAME=korwin-mikke
export REGION=europe-central2
export ZONE=europe-central2-a
export NODE_LOCATION=europe-central2-a
export NUMBER_OF_NODES=3
export NETWORK=gke-vpc-network
export SUBNET=gke-vpc-subnet
export FIREWALL_RULE_NAME=gke-port-80

# Create VPC network
gcloud compute networks create $NETWORK --project=$PROJECT --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional

# Create subnet
gcloud compute networks subnets create $SUBNET --project=$PROJECT --range=10.10.0.0/17 --stack-type=IPV4_ONLY --network=$NETWORK --region=$REGION

# Create cluster
gcloud container clusters create $CLUSTER_NAME \
    --gateway-api=standard \
    --enable-l4-ilb-subsetting \
    --zone $ZONE \
    --node-locations $NODE_LOCATION \
    --num-nodes=$NUMBER_OF_NODES \
    --spot \
    --network=$NETWORK \
    --subnetwork=$SUBNET

# Create firewall rule to open port 80
gcloud compute firewall-rules create $FIREWALL_RULE_NAME \
    --allow=tcp:80 \
    --description="Allow incoming traffic on TCP port 80" \
    --direction=INGRESS \
    --network=$NETWORK \
    --source-ranges="0.0.0.0/0"

# Get cluster credentials
gcloud container clusters get-credentials $CLUSTER_NAME \
    --zone $ZONE \
    --project $PROJECT


