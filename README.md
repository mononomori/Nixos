# Nixos Configuration Files

## Desktop Example:

![alt text](desktop-example.png)

## Configuration Structure:

```
.
├── flake.nix
├── flake.lock
├── modules
│   ├── home-manager
│   │   ├── home-module1.nix
│   │   ├── home-module2.nix
│   │   └── ...
│   └── nixos
│       ├── system-module1.nix
│       ├── system-module2.nix
│       └── ...
├── hosts
│   ├── host1
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
│   │   └── users
│   │       ├── user1.nix
│   │       └── ...
│   ├── host2
│   │   ├── configuration.nix
│   │   ├── hardware-configuration.nix
│   │   └── users
│   │       ├── user1.nix
│   │       └── ...
│   └── ...
```

