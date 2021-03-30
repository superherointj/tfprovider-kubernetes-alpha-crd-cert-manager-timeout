# WIP! Ignore this! This is not ready for use! I just pasted stuff...
{
  description = "Demo of Terraform's Kubernetes-Alpha installing Cert-Manager in Linode LKE ";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "tf-kubernetes-alpha-cert-manager-timeout-demo";
        src = self;

      # terraform_0_14.withPlugins (tp: [ tp.digitalocean ]);

        buildInputs = 
          let terraformPlugins = terraform_0_14.withPlugins (tp: with tp; [
              linode
              helm
              kubernetes
              kubernetes-alpha
              # cert-manager 
            ]); in
           [ terraformPlugins ];


        #   (with terraform_0_14.withPlugins (p: [
        #   p.archive
        #   # p.aws
        #   p.external
        #   # p.gitlab
        #   p.Linode
        #   # p.grafana
        #   p.helm
        #   p.kubernetes
        #   p.local
        #   p.null
        #   p.random
        #   p.template
        #   p.tls
        # ]));

        buildPhase = ''
          export TF_CLI_CONFIG_FILE=terraform.rc
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