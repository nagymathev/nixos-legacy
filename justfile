alias sw := switch
alias up := update
alias uh := update-home

# rebuild system
switch:
    sudo nixos-rebuild switch --show-trace
boot:
    sudo nixos-rebuild boot
update:
    sudo nix flake update
update-home:
    sudo nix flake lock --update-input home-manager