# golang-lambda-terraform-sample

## golang

https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/golang-package.html

```sh
$ docker-compose run --rm lambda sh
$ apk add zip
$ cd app
$ GOARCH=amd64 GOOS=linux go build main.go && zip ../function.zip main
```

## terraform

```sh
$ docker-compose run --rm terraform sh
$ terraform apply
```

## test

https://ap-northeast-1.console.aws.amazon.com/lambda/home?region=ap-northeast-1#/functions/my_lambda_function?tab=testing
