# Use the Alpine latest image as the base image
FROM alpine:latest

# Arguments for the SSH master username and password
ARG SSH_MASTER_PASS
ARG PERMIT_PASSWORD_LOGIN

# Install required packages
RUN apk --no-cache add nano sudo openssh-server bash

# Create a directory required for SSHD
RUN mkdir -p /run/sshd && chmod 0755 /run/sshd

# Generate SSH host keys
RUN ssh-keygen -A

# Copy configuration data for SSH
COPY ssh_config /etc/ssh/ssh_config
COPY sshd_config /etc/ssh/sshd_config

# Copy and execute sshd configuration script
COPY configure-sshd.sh /usr/local/bin/configure-sshd.sh
RUN chmod +x /usr/local/bin/configure-sshd.sh
RUN source /usr/local/bin/configure-sshd.sh
RUN rm /usr/local/bin/configure-sshd.sh

# Copy and execute user creation script
COPY user.sh /usr/local/bin/user.sh
RUN chmod +x /usr/local/bin/user.sh
RUN /usr/local/bin/user.sh
RUN rm /usr/local/bin/user.sh

COPY addusers.sh /usr/local/bin/addusers.sh
RUN chmod 755 /usr/local/bin/addusers.sh && chown root:root /usr/local/bin/addusers.sh

# Create a directory for SFTP data and set permissions
RUN mkdir /data && chmod 755 /data && chown root:root /data
RUN mkdir /data/sftp-user && chmod 700 /data/sftp-user
RUN chown sftp-user:sftp-user /data/sftp-user


# Copy and set permissions for the entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Switch to the SSH master user
USER sftp-user

ENTRYPOINT ["sudo", "-E","/usr/local/bin/entrypoint.sh"]
