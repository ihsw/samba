FROM ubuntu:14.04

RUN apt-get update && apt-get install -yq samba
EXPOSE 445

ENV USER derp
ENV PASSWORD password
RUN useradd -M $USER
RUN echo "$USER:$PASSWORD" | chpasswd
RUN echo "$PASSWORD\n$PASSWORD" | pdbedit -a $USER

ENV SHARED_DIR /mnt/files
RUN mkdir $SHARED_DIR
RUN chown -R $USER:$USER $SHARED_DIR

COPY ./etc/samba/smb.conf /etc/samba/smb.conf

CMD ["/usr/sbin/smbd", "-FS"]