FROM microsoft/powershell:ubuntu16.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install openssh-server openssh-client -y

RUN echo 'root:p@$5w0rd' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN sed 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed '/Subsystem sftp \/usr\/lib\/openssh\/sftp-server/a Subsystem powershell \/usr\/bin\/pwsh -sshs -NoLogo -NoProfile' /etc/ssh/sshd_config
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22/tcp
CMD [ "/bin/bash" ]
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
