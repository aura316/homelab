# Homelab
## ZFS
ZFS two datasets, one for media and another for important data
1 pool
2 datasets mounted in /data and the other in /data-critical

## Tailscale
Services are exposed via tailscale service functionality.

Example:
`tailscale serve --service=svc:jellyfin --https=443 127.0.0.1:8096`