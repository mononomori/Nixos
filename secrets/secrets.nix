let
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIINzfZRCrL80O+5eidfmHhKZUvpkTtI025OIvO+yL30D";
  user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK6mfDbjiHrM6W03x6ZBFKMb10j0kWZkyJEwyVjxHD5Z";
in
{
  "yamtrack-secret.age".publicKeys = [
    system
    user
  ];
  "ssh-hosts.age".publicKeys = [
    system
    user
  ];

}
