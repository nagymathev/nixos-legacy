alias sw := switch
alias up := update

# rebuild system
switch:
    sudo nixos-rebuild switch
boot:
    sudo nixos-rebuild boot
update:
    sudo nix flake update
update-home:
    sudo nix flake lock --update-input home-manager