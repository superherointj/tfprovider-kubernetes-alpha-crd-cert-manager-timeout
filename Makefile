DEFAULT: base demo run #dump

base:
	docker build --no-cache -t archbase -f Dockerfile.archbase .

demo:
	docker build --no-cache -t timeout-demo .

run:
	docker run -it --env-file .env timeout-demo
	# docker run -e MYVAR1 --env MYVAR2=foo --env-file ./env.list ubuntu bash

#dump:
#	`docker ps -a | grep timeout-demo | cut -d' ' -f1` | xargs `docker cp $1:/workdir/tfprovider-kubernetes-alpha-crd-cert-manager-timeout/ ./dump/$1/`

clean:
	rm -r *.log dump
