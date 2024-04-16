
kubectl apply -f secret.yaml

kubectl describe sa default

kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "rh-pull-secret"}]}'

kubectl describe sa default

