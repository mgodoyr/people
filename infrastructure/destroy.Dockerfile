FROM hashicorp/terraform:latest
WORKDIR /infrastructure
ADD . /infrastructure
RUN export $(xargs < .env) && \
    printenv | more && \
    terraform init && \
    terraform get && \
    terraform validate && \
    terraform plan && \
    terraform destroy -auto-approve