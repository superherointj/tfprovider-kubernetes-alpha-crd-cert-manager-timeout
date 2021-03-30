DEFAULT: base demo run dump

demo:
	docker build --no-cache -t timeout-demo .

base:
	docker build --no-cache -t archbase -f Dockerfile.archbase .

run:
	docker run -it --env-file .env timeout-demo
	# docker run -e MYVAR1 --env MYVAR2=foo --env-file ./env.list ubuntu bash

clean:
	rm *.log

dump:
	docker cp `docker ps | grep timeout-demo | cut -d' ' -f1`:/workdir/tfprovider-kubernetes-alpha-crd-cert-manager-timeout/ ./dump/
