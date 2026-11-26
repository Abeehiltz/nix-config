#!/usr/bin/env fish
for server in dmz-reverse-proxy glance
 nixos-rebuild switch --flake .#$server --target-host abee@$server --build-host localhost --sudo 
end
