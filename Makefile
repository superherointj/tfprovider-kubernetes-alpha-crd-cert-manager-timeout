DEFAULT: base demo run dump

base:
	docker build --no-cache -t archbase -f Dockerfile.archbase .

demo:
	docker build --no-cache -t timeout-demo .

run:
	docker run -it --env-file .env timeout-demo

dump:
	mkdir -p logs/docker/
	docker cp $(docker ps -a -n1 | grep timeout-demo | cut -d' ' -f1):/workdir/tfprovider-kubernetes-alpha-crd-cert-manager-timeout/logs/docker/ ./logs/docker/

clean:
	rm -rf *.log logs
