# mellana-bot

**After test, it was deemed a full twitch bot was not necessary. This project has been abandoned for the moment.**

[PhantomBot](https://github.com/PhantomBot/PhantomBot) twitch bot for [Mellana's stream](https://twitch.tv/mellana). Basically PhantomBot with extra custom modules installed on top to remove some of the non-family friendly features, built as a docker container.

## dev

Helpers to build, run, and stop the docker container in development.

#### build
```sh
./.dev/docker.sh build
```

#### run
```sh
./.dev/docker.sh run
```

#### stop
```sh
./.dev/docker.sh stop
```

## release

Helper to release major, minor, patch versions.
- Build docker image
- Git commit with version
- Git tag said commit
- Docker tag built image with version
- Push to docker hub

```sh
./.dev/release.sh {major|minor|patch}
```



