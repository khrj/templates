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
					nativeBuildInputs = [ pkgs.bashInteractive ];
					buildInputs = with pkgs; [
						nodejs_21
						nodePackages.prisma
					];
					shellHook = ''
						sudo systemctl start postgresql.service
						export PRISMA_SCHEMA_ENGINE_BINARY="${pkgs.prisma-engines}/bin/schema-engine"
						export PRISMA_QUERY_ENGINE_BINARY="${pkgs.prisma-engines}/bin/query-engine"
						export PRISMA_QUERY_ENGINE_LIBRARY="${pkgs.prisma-engines}/lib/libquery_engine.node"
						export PRISMA_ENGINES_CHECKSUM_IGNORE_MISSING=1
					'';
				};
			}
		);
}