# test-terraform-aws
A project to test a workflow that deploy to my aws infraestructure with terraform

## Políticas de identidad

Agregar proveedor de identidad: OpenID Connect

URL de proveedor: token.actions.githubusercontent.com

Público: sts.amazonaws.com

## AWS_OIDC_ROLE

Crear rol -> Identidad web -> Elegir la identidad creada anteriormente

Entidades de confianza

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::008085406668:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                },
                "StringLike": {
                    "token.actions.githubusercontent.com:sub": [
                        "repo:argelion14/test-terraform-aws:*",
                        "repo:argelion14/test-terraform-aws"
                    ]
                }
            }
        }
    ]
}
```

## AWS_DEPLOYER_ROLE

Crear rol -> Cuenta de AWS

Entidades de confianza

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::008085406668:role/AWS_OIDC_ROLE"
            },
            "Action": [
                "sts:AssumeRole",
                "sts:TagSession"
            ]
        }
    ]
}
```

Permisos

- AmazonCloudWatchEvidentlyFullAccess
- AmazonEC2FullAccess
- AmazonS3FullAccess
- IAMReadOnlyAccess


<a href="https://trackgit.com">
<img src="https://us-central1-trackgit-analytics.cloudfunctions.net/token/ping/miuvvj6v790jcmq665am" alt="trackgit-views" />
</a>
