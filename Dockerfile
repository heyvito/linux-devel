FROM archlinux:latest

RUN echo -e 'Server = http://linorg.usp.br/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
RUN pacman -Sy --noconfirm \
    ack \
    base-devel \
    clang \
    cmake \
    curl \
    expect \
    git \
    inetutils \
    make \
    openbsd-netcat \
    patchelf \
    python \
    vim \
    zip \
    zsh
RUN pacman -Sy --noconfirm --asdeps xxd

RUN useradd -rm -d /home/docker -s /sbin/zsh -G wheel -u 1000 docker
RUN echo "docker:x:501:0::/home/docker:/bin/zsh" >> /etc/passwd
RUN sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers

ENV PATH=/usr/bin/vendor_perl:/usr/bin/core_perl:$PATH

USER docker
