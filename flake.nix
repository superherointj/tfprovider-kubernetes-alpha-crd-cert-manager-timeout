{
  description = "Demo of Terraform's Kubernetes-Alpha installing Cert-Manager in Linode LKE ";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "tf-kubernetes-alpha-cert-manager-timeout-demo";
        src = self;
        buildInputs = [ terraform_0_14 ];
        buildPhase = ''
            export TF_LOG=TRACE; export TF_LOG_PATH=tf-timeout-demo.log
            TF_LOG_PATH=tf-init.log terraform init
            TF_LOG_PATH=tf-lke_cluster.log terraform apply -target linode_lke_cluster.timeout_demo_lke
            TF_LOG_PATH=tf-kubeconfig.log terraform output kubeconfig | sed -e 's/^"//' -e 's/"$//' | base64 -d > kubeconfig.yaml
            TF_LOG_PATH=tf-apply.log terraform apply        
        '';
        installPhase = "mkdir -p $out/logs; cp *.log $out/logs/";
      };

  };
}