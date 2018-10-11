docker build -t kiano/multi-client:latest -t kiano/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t kiano/multi-server:latest -t kiano/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t kiano/multi-worker:latest -t kiano/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push kiano/multi-client:latest
docker push kiano/multi-server:latest
docker push kiano/multi-worker:latest

docker push kiano/multi-client:$GIT_SHA
docker push kiano/multi-server:$GIT_SHA
docker push kiano/multi-worker:$GIT_SHA

kubectl apply -f ./k8s
kubectl set image deployments/client-deployment client=kiano/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=kiano/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=kiano/multi-worker:$GIT_SHA