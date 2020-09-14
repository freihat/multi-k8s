docker build -t bkrfr/multi-client:latest -t bkrfr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bkrfr/multi-server:latest -t bkrfr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bkrfr/multi-worker:latest -t bkrfr/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bkrfr/multi-client
docker push bkrfr/multi-server 
docker push bkrfr/multi-worker 
kubectl apply -f k8s

kubectl set image deployments/client-deployment client=bkrfr/multi-client:$SHA
kubectl set image deployments/server-deployment server=bkrfr/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=bkrfr/multi-worker:$SHA 