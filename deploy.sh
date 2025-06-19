docker build -t viswa241089/multi-client-k8s:latest -t viswa241089/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t viswa241089/multi-server-k8s:latest -t viswa241089/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t viswa241089/multi-worker-k8s:latest -t viswa241089/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push viswa241089/multi-client-k8s:latest
docker push viswa241089/multi-server-k8s:latest
docker push viswa241089/multi-worker-k8s:latest

docker push viswa241089/multi-client-k8s:$SHA
docker push viswa241089/multi-server-k8s:$SHA
docker push viswa241089/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=viswa241089/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=viswa241089/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=viswa241089/multi-worker-k8s:$SHA
