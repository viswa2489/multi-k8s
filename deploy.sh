docker build -t viswa2489/multi-client-k8s:latest -t viswa2489/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t viswa2489/multi-server-k8s:latest -t viswa2489/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t viswa2489/multi-worker-k8s:latest -t viswa2489/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push viswa2489/multi-client-k8s:latest
docker push viswa2489/multi-server-k8s:latest
docker push viswa2489/multi-worker-k8s:latest

docker push viswa2489/multi-client-k8s:$SHA
docker push viswa2489/multi-server-k8s:$SHA
docker push viswa2489/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=viswa2489/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=viswa2489/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=viswa2489/multi-worker-k8s:$SHA
