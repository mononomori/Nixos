let
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIINzfZRCrL80O+5eidfmHhKZUvpkTtI025OIvO+yL30D";
  user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK6mfDbjiHrM6W03x6ZBFKMb10j0kWZkyJEwyVjxHD5Z";
  agenix_2b = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKjOn9mnXh+vvblygktKWnVZ12w94xail8KR3DjgMJZu";
in
{
  "yamtrack-secret.age".publicKeys = [
    system
    user
  ];
  "ssh-hosts.age".publicKeys = [
    system
    user
    agenix_2b
  ];

}
