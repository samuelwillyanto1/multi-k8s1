docker build -t samuelwillyanto/multi-client:latest -t samuelwillyanto/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t samuelwillyanto/multi-server:latest -t samuelwillyanto/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t samuelwillyanto/multi-worker:latest -t samuelwillyanto/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push samuelwillyanto/multi-client:latest
docker push samuelwillyanto/multi-server:latest
docker push samuelwillyanto/multi-worker:latest

docker push samuelwillyanto/multi-client:$SHA
docker push samuelwillyanto/multi-server:$SHA
docker push samuelwillyanto/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=samuelwillyanto/multi-server:$SHA
kubectl set image deployments/client-deployment client=samuelwillyanto/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=samuelwillyanto/multi-worker:$SHA