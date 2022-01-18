with import <nixpkgs> {};

mkShell {
  nativeBuildInputs = with pkgs; [ 
    kubernetes-helm
  ];
}
