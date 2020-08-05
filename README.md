People Rest API (GCP/GKE)

Requirments

- Docker
- gcloud sdk
- kubectl

Stack:
 - Loopback 4 (Node JS)
 - Terraform
 - Bash
 
---
 
*Deployed at GCP*

---

You must create a .env file with the following envrioment variables

```dotenv
CLUSTER_NAME="<cluster-name>"
REGION="<region-name>"
APP_NAME="<app-name>"
PROJECT_ID="<project-id>"
PROJECT="<project-name>"
VERSION_APP="<application-version>"
APP_PORT=<application-port>
DEPLOYMENT="<deployment-name>"
ACCOUNT="<account-service-email>"
BILLING_ID="<billing-gcp-id>"
```

then, just must put here your service account credential file from GCP console

is like this:

```json
{
  "type": "<string>",
  "project_id": "<string>",
  "private_key_id": "<string>",
  "private_key": "<string>",
  "client_email": "<string>",
  "client_id": "<string>",
  "auth_uri": "<string>",
  "token_uri": "<string>",
  "auth_provider_x509_cert_url": "<string>",
  "client_x509_cert_url": "<string>"
}
```

to provision infrastructure run:

```shell script
chmod +x deploy
./deploy -a infrastructure
```

to provision the application (Rest API) run:

```shell script
./deploy -a application
```
this cluster application is published under Cloudflare and Apigee Gateway (Edge)

---

**How to consume**

API is manage by Apigee, you must enter to this temporal endpoint

`https://weare-eval-prod.apigee.net`

to get an access token, use this one Curl request snippet

```shell script
curl --location --request GET 'https://weare-eval-prod.apigee.net/oauth/accesstoken' \
--header 'Authorization: Basic bWpRcVhxNWVES3JKaXc3ZmxiVEh2RnAzcEE5d2t1enY6WFk0bU1oRnFEQVUybE9HVg==' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=client_credentials'
```

that Authorization token is a basic key and secret string to authenticate with a account in Apigee

You can use directly Portal API deploy with Apigee to create your own account

https://weare-eval-people.apigee.io/

from that account you can retrieve a key and secret string for your account

---

Aditional API reference documentation

https://documenter.getpostman.com/view/860855/T1LFoWAb?version=latest

https://23people.docs.apiary.io



---






