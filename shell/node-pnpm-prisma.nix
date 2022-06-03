{
	inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

	outputs = { self, nixpkgs }:
		let 
			pkgs = nixpkgs.legacyPackages.x86_64-linux;
		in {
			devShell.x86_64-linux = pkgs.mkShell {
				nativeBuildInputs = [ pkgs.bashInteractive ];
				buildInputs = with pkgs; [
					nodejs-18_x
					nodePackages.pnpm
					nodePackages.prisma
				];
				shellHook = with pkgs; ''
					export PRISMA_MIGRATION_ENGINE_BINARY="${prisma-engines}/bin/migration-engine"
					export PRISMA_QUERY_ENGINE_BINARY="${prisma-engines}/bin/query-engine"
					export PRISMA_QUERY_ENGINE_LIBRARY="${prisma-engines}/lib/libquery_engine.node"
					export PRISMA_INTROSPECTION_ENGINE_BINARY="${prisma-engines}/bin/introspection-engine"
					export PRISMA_FMT_BINARY="${prisma-engines}/bin/prisma-fmt"
				'';
			};
		};
}