# Use the Alpine latest image as the base image
FROM alpine:latest

# Arguments for the SSH master username and password
ARG PERMIT_PASSWORD_LOGIN

# Install packages, Create directories and Generate SSH host keys
RUN apk --no-cache add nano sudo openssh-server bash && \
    mkdir -p /run/sshd && chmod 0755 /run/sshd && \
    ssh-keygen -A

# Copy configuration data for SSH
COPY ssh_config /etc/ssh/ssh_config
COPY sshd_config /etc/ssh/sshd_config

# Copy and execute sshd configuration script
COPY configure-sshd.sh /usr/local/bin/configure-sshd.sh
RUN chmod +x /usr/local/bin/configure-sshd.sh
RUN source /usr/local/bin/configure-sshd.sh
RUN rm /usr/local/bin/configure-sshd.sh

# Copy and execute user creation script
COPY configure-user.sh /usr/local/bin/configure-user.sh
RUN chmod +x /usr/local/bin/configure-user.sh
RUN /usr/local/bin/configure-user.sh
RUN rm /usr/local/bin/configure-user.sh

COPY user-utilities /usr/local/bin/user-utilities
RUN chmod 755 /usr/local/bin/user-utilities && chown root:root /usr/local/bin/user-utilities
COPY password-manager /usr/local/bin/password-manager
RUN chmod 700 /usr/local/bin/password-manager && chown root:root /usr/local/bin/password-manager

# Create a directory for SFTP data and set permissions
RUN mkdir /data && chmod 755 /data && chown root:root /data
RUN mkdir /data/sftp-user && chmod 700 /data/sftp-user
RUN chown sftp-user:sftp-user /data/sftp-user


# Copy and set permissions for the entrypoint script
COPY entrypoint /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

# Switch to the SSH master user
USER sftp-user

ENTRYPOINT ["sudo", "-E","/usr/local/bin/entrypoint"]
