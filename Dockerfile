FROM archlinux:latest

RUN pacman-key --init
# Update the package database and install dependencies
RUN pacman -Syu --noconfirm \
    base-devel \
    git \
    make \
    cmake \
    curl \
    openssl \
    python \
    python-pip \
    coreutils \
    && pacman -Scc --noconfirm

WORKDIR /telegram_bot

COPY . .
# COPY start.sh ./start.sh
RUN chmod +x ./start.sh

# Expose the port (change if needed)
EXPOSE 8667

ENTRYPOINT ["./start.sh"]
