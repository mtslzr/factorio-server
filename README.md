# factorio-server

Copy the server settings example file and adjust the settings.

```shell
cd docker && cp server-settings{.example,}.json
```

(Optional) Build the Docker image.

```shell
make build
```
Deploy to AWS.

```shell
make deploy
```
