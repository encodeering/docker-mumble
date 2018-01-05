## Automatically created docker image for mumble and bots

[![Build Status](https://travis-ci.org/encodeering/docker-mumble.svg?branch=master)](https://travis-ci.org/encodeering/docker-mumble)

### Docker

#### Murmur ([Origin](https://github.com/containerly/library/tree/master/library/murmur))

- https://hub.docker.com/r/encodeering/mumble-armhf/

    ```docker pull encodeering/mumble-armhf:1.2.19-murmur```

- https://hub.docker.com/r/encodeering/mumble-amd64/

    ```docker pull encodeering/mumble-amd64:1.2.19-murmur```

#### DJ ([Origin](https://github.com/matthieugrieger/mumbledj))

- https://hub.docker.com/r/encodeering/mumble-armhf/

    ```docker pull encodeering/mumble-armhf:3.2.1-dj```

- https://hub.docker.com/r/encodeering/mumble-amd64/

    ```docker pull encodeering/mumble-amd64:3.2.1-dj```

### Compose

```yml
version: '3'
services:
  murmur:
    image: encodeering/mumble-amd64:1.2.19-murmur
    volumes:
      - ./murmur:/data
    ports:
      - "64738:64738/tcp"
      - "64738:64738/udp"
    environment:
      - MUMBLE_REGISTERPASSWORD=registersecret
      - MUMBLE_SERVERPASSWORD=serversecret
      - MUMBLE_ENABLESSL=0 # /data/cert.pem, /data/key.pem
      - MUMBLE_SSLPASSPHRASE=---
  dj:
    image: encodeering/mumble-amd64:3.2.1-dj
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