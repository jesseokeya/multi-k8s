docker build -t jesseokeya/multi-client:latest -t jesseokeya/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jesseokeya/multi-server:latest -t jesseokeya/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jesseokeya/multi-worker:latest -t jesseokeya/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jesseokeya/multi-client:latest
docker push jesseokeya/multi-server:latest
docker push jesseokeya/multi-worker:latest

docker push jesseokeya/multi-client:$SHA
docker push jesseokeya/multi-server:$SHA
docker push jesseokeya/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jesseokeya/multi-server:$SHA
kubectl set image deployments/client-deployment client=jesseokeya/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jesseokeya/multi-worker:$SHA