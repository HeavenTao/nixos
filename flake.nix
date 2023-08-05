{
	description = "Heaven's NixOS settings";
	inputs={
		nixpkgs.url="github:NixOS/nixpkgs/nixos-unstable";
		home-manager={
			url="github:nix-community/home-manager/release-23.05";
			inputs.nixpkgs.follows="nixpkgs";
		};
	};

	outputs = { self, nixpkgs,home-manager,... }@inputs: {
		nixosConfigurations={
			"nixos"=nixpkgs.lib.nixosSystem {
				system="x86_64-linux";
				modules=[
					./configuration.nix
						home-manager.nixosModules.home-manager
						{
							home-manager.useGlobalPkgs=true;
							home-manager.useUserPackages=true;
							home-manager.user.ht=import ./home.nix;
						}
				];
			};
		};
	};
}
