## Automatically created docker image for mumble and bots

### Docker

#### Murmur ([Origin](https://github.com/containerly/library/tree/master/library/murmur))

- https://hub.docker.com/r/encodeering/mumble-armhf/
- https://hub.docker.com/r/encodeering/mumble-amd64/

#### DJ ([Origin](https://github.com/matthieugrieger/mumbledj))

- https://hub.docker.com/r/encodeering/mumble-armhf/
- https://hub.docker.com/r/encodeering/mumble-amd64/

### Compose

```yml
version: '3'
services:
  murmur:
    image: encodeering/mumble-amd64:1.5.634-murmur
    volumes:
      - ./murmur:/data
    ports:
      - "64738:64738/tcp"
      - "64738:64738/udp"
    environment:
      - MUMBLE_CONFIG_SERVER_PASSWORD=serversecret
      - MUMBLE_SUPERUSER_PASSWORD=superusersecret
  dj:
    image: encodeering/mumble-amd64:3.3.1-dj
    volumes:
      - ./dj:/root/.cache/mumbledj
    command: [
      "--insecure",
      "--server=murmur",
      "--username=DJ",
      "--password=serversecret",
      "--admins.names=SuperUser",
      "--api_keys.youtube=",
      "--api_keys.soundcloud=",
      "--cache.enabled=true"
    ]
```
