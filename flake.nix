{
  inputs = {
    master = { url = "github:nixos/nixpkgs/master"; };
    stable = { url = "github:nixos/nixpkgs/nixos-20.03"; };
    unstable = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    home = { url = "github:rycee/home-manager/bqv-flakes"; };

    wayland = {
      url = "github:colemickens/nixpkgs-wayland/master";
      inputs = {
        nixpkgs.follows = "master";
        master.follows = "master";
      };
    };
  };

  outputs = inputs: {

    nixosConfigurations = {
      clevo-n141zu = inputs.unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./machines/clevo-n141zu/configuration.nix ];
        specialArgs = {
          username = "romain";
          realname = "Romain Viallard";
          email = "romain.viallard@outlook.fr";
          inherit inputs;
        };
      };
    };

    machines = {
      clevo-n141zu = inputs.self.nixosConfigurations.clevo-n141zu.config.system.build.toplevel;
    };
    
  };
}
