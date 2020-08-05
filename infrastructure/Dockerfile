FROM hashicorp/terraform:latest
WORKDIR /infrastructure
ADD . /infrastructure
RUN export $(xargs < .env) && \
    printenv | more && \
    terraform init && \
    terraform get && \
    terraform validate && \
    terraform refresh && \
    terraform plan && \
    terraform apply -auto-approve