FROM python:latest

# Update and install required packages
RUN apt update && apt upgrade -y \
    && apt install -y openssh-server iproute2 iputils-ping python3 python3-pip \
    && pip3 install pyyaml

# Add public key
RUN mkdir -p /root/.ssh \
    && echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEOEQDkKxlKvnsMG8YHcOrQw1lj5gpAUMpahi7miNlpu clab@suse' > /root/.ssh/authorized_keys

# Set up configuration for SSH
RUN mkdir /var/run/sshd \
    && sed -i -E 's/#(PermitRootLogin|PubkeyAuthentication).*/\1 yes/' /etc/ssh/sshd_config \
    && sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd \
    && echo "export VISIBLE=now" >> /etc/profile

# Create a volume for Python files
VOLUME /root/pythonfiles

EXPOSE 22

# Run SSH
CMD ["/usr/sbin/sshd", "-D"]
