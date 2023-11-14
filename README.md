# Terraform-AWS


Build requirements:
    Jenkins orchestration server:
        - Ubuntu 2
        - Java 17
        - Jenkins
            -Plugins:
            - Docker Pipeline
                - Permissions issue: Got permission denied while trying to connect to the Docker daemon socket
                - Solution: https://www.digitalocean.com/community/questions/how-to-fix-docker-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket

    Jenkin operation server:
        - Terraform
        - Python 3
        - Python3-pip
            -sudo apt install python3-pip
        - Boto3 (AWS Python SDK)
            -pip install boto3
        -python-terraform
            -pip install python-terraform
            -https://pypi.org/project/python-terraform/
        - Docker
            - Issue installing: Package docker-ce is not available, but is referred to by another package.
            This may mean that the package is missing, has been obsoleted, or
            is only available from another source
            E: Package 'docker-ce' has no installation candidate
            E: Unable to locate package docker-ce-cli
            E: Unable to locate package containerd.io
            E: Couldn't find any package by glob 'containerd.io'
            E: Couldn't find any package by regex 'containerd.io'
            - Solution: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04# Terraform-AWS
