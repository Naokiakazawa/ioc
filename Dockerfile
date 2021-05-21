FROM ubuntu:20.04

# install command aws-cli v2 azure-cli terraform ansible.
RUN apt-get update && apt-get install -y less unzip curl software-properties-common && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.2.5.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    bash -c 'echo complete -C '/usr/bin/aws_completer' aws  >> $HOME/.bashrc' && \
    rm /awscliv2.zip && \
    curl -sL https://aka.ms/InstallAzureCLIDeb | bash && \
    curl "https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_linux_amd64.zip" -o "terraform.zip" && \
    unzip ./terraform.zip -d /usr/local/bin/ && \
    rm /terraform.zip && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && \
    apt-get update && \
    apt-get install google-cloud-sdk -y && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt-get install ansible -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /infra/terraform

# initialize command.
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
#COPY ./providers/.aws /infra/.aws
#COPY ./providers/init.sh /infra/init.sh
#RUN chmod +x /infra/init.sh && /infra/init.sh