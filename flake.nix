{
  inputs = {
    master = { url = "github:nixos/nixpkgs/master"; };
    stable = { url = "github:nixos/nixpkgs/nixos-20.03"; };
    unstable = { url = "github:nixos/nixpkgs/nixos-unstable"; };
  };

  outputs = inputs: {

    nixosConfigurations = {
      clevo-n141zu = inputs.unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./machines/clevo-n141zu/configuration.nix ];
        specialArgs = { inherit inputs; };
      };
    };

    machines = {
      clevo-n141zu = inputs.self.nixosConfigurations.clevo-n141zu.config.system.build.toplevel;
    };
    
  };
}
