FROM archbase

RUN git clone https://github.com/superherointj/tfprovider-kubernetes-alpha-crd-cert-manager-timeout

WORKDIR /workdir/tfprovider-kubernetes-alpha-crd-cert-manager-timeout

RUN chmod +x bootstrap.sh

CMD /workdir/tfprovider-kubernetes-alpha-crd-cert-manager-timeout/bootstrap.sh $@
