docker build -t michal77/multi-client:latest -t michal77/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t michal77/multi-server:latest -t michal77/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t michal77/multi-worker:latest -t michal77/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push michal77/multi-client:latest
docker push michal77/multi-client:$SHA
docker push michal77/multi-server:latest
docker push michal77/multi-server:$SHA
docker push michal77/multi-worker:latest
docker push michal77/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=michal77/multi-client:$SHA
kubectl set image deployments/server-deployment server=michal77/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=michal77/multi-worker:$SHA