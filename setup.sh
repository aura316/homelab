#!/bin/bash
echo "Setting up..."
echo ""

### Silent push and pop
pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd "$@" > /dev/null
}
###

#### DOCKER CONFIG DIRS ####
sudo mkdir -p /docker/secrets /docker/appdata
### Traefik
pushd /docker/appdata
sudo mkdir -p traefik3
sudo mkdir -p traefik3/acme
sudo mkdir -p traefik3/rules

sudo touch /docker/secrets/cf_dns_api_token # Cloudflare DNS API token
sudo touch /docker/appdata/traefik3/acme/acme.json # Certificate file
popd

# Copy middleware to location

### NOTE the rules folder must be correctly mapped to the traefik /rules, in case you change that directory
sudo cp -n ./traefik3/middleware-oauth.yml /docker/appdata/traefik3/rules/ # Google auth configuration
sudo cp -n ./traefik3/oauth_secrets /docker/secrets/ # Google auth configuration

echo "Don't forget:"
echo " - to configure google's authentication at /docker/secrets/oauth_secrets!"
echo "   - \"secret\" can be generated with: openssl rand -hex 16"
echo " - to put the DNS API KEY in /docker/secrets/cf_dns_api_token"
echo " - define a static ip in this machine"

#### MEDIA SERVER DIRECTORY LAYOUT ####

### TORRENT DIRS SETUP ###
sudo mkdir -p /data/torrents
pushd /data/torrents
mkdir -p tvshows anime movies prowlarr
popd

### USENET DIRS (DISABLED) ###
sudo mkdir -p /data/usenet/complete
pushd /data/usenet/complete
sudo mkdir -p tvshows anime movies prowlarr
popd

### MEDIA DIRS ###
sudo mkdir -p /data/media
pushd /data/media
sudo mkdir -p tvshows anime movies
popd


#### ADD PERMISSIONS ####
sudo chown -R $USER:$USER /data
sudo chmod -R a=,a+rX,u+w,g+w /data

sudo chown -R $USER:$USER /docker
sudo chmod -R a=,a+rX,u+w,g+w /docker

# ACME specifically needs 600 permission
sudo chmod 600 /docker/appdata/traefik3/acme/acme.json

echo ""
echo "Done!"
