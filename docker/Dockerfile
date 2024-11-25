FROM ubuntu:latest
RUN apt update && apt upgrade -y
RUN apt install openssh-server -y
RUN apt install iproute2 -y
RUN apt install iputils-ping -y
RUN apt install less -y
RUN apt install vim -y
RUN apt install python3 -y
RUN apt install bzip2 -y


# Add public key
RUN mkdir -p /root/.ssh
RUN echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEOEQDkKxlKvnsMG8YHcOrQw1lj5gpAUMpahi7miNlpu clab@suse' > /root/.ssh/authorized_keys


# Set up configuration for SSH
RUN mkdir /var/run/sshd 
RUN sed -i -E 's/#(PermitRootLogin|PubkeyAuthentication).*/\1 yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd 
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
# Run SSH
CMD ["/usr/sbin/sshd", "-D"]
