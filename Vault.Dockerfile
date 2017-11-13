FROM centos:latest
WORKDIR /root

RUN yum -y update && \
    yum -y install wget unzip && \
    wget https://releases.hashicorp.com/vault/0.8.3/vault_0.8.3_linux_amd64.zip && \
    unzip vault_0.8.3_linux_amd64.zip && \
    cp vault /bin && \
    export VAULT_ADDR='http://127.0.0.1:8200'

CMD [ "/bin/bash" ]
EXPOSE 8200/tcp

ENTRYPOINT [ "vault", "server", "-dev" ]
