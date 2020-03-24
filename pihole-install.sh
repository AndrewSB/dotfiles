# Install pihole locally running inside a docker container on the machine. Then 
# updates DNS to use the pihole running inside docker. Saves about 40% bandwidth
# whilst browsing the web in my experience.

set -e

brew cask install docker
open /Applications/Docker.app

# From https://unix.stackexchange.com/a/293941
read -n 1 -s -r -p "Once Docker Desktop is green and running, press any key to continue"
printf "\n"

# From https://www.reddit.com/r/pihole/comments/9k6lzp/run_pihole_on_macos_mojave_with_docker/
docker pull pihole/pihole
LOCAL_IP=$(ipconfig getifaddr en0)
docker run -d --name pihole -e ServerIP=$LOCAL_IP -e WEBPASSWORD="password" -e DNS1=8.8.8.8 -p 80:80 -p 53:53/tcp -p 53:53/udp -p 443:443 pihole/pihole:latest
networksetup -setdnsservers Wi-Fi 127.0.0.1
docker ps -a
open http://pi.hole/admin

set +e 
