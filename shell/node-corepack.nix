{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, flake-utils }:
		flake-utils.lib.eachDefaultSystem (system:
			let pkgs = nixpkgs.legacyPackages.${system};
			in {
				devShell = pkgs.mkShell {
					buildInputs = with pkgs; [
						nodejs-18_x
					];
					shellHook = ''
						mkdir -p .corepack
						corepack enable --install-directory="./.corepack"
						export PATH=$PATH:$(cd .corepack; pwd)
					'';
				};
			}
		);
}