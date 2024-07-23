# factorio-server

Copy the server settings example file and adjust the settings.

```shell
cd docker && cp server-settings{.example,}.json
```

Deploy the ECR repository to AWS.

```shell
make repo
```

(Optional) Test building the Docker image.

```shell
make build
```
Deploy to AWS.

```shell
make deploy
```
