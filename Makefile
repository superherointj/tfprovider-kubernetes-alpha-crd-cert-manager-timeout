DEFAULT: base demo run get-logs

base:
	docker build --no-cache -t archbase -f Dockerfile.archbase .

demo:
	docker build --no-cache -t timeout-demo .

run:
	docker run -it --env-file .env timeout-demo

get-logs:
	mkdir -p logs
	docker ps -a -n1 | grep timeout-demo | cut -d' ' -f1 | xargs -I {} docker cp {}:/workdir/tfprovider-kubernetes-alpha-crd-cert-manager-timeout/logs/docker/ ./logs/

clean:
	rm -rf *.log logs
