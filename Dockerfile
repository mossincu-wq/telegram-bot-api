# Use Arch Linux as the base image
FROM archlinux:latest

# Set environment variables to avoid prompts
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV TZ=UTC

# RUN cat /etc/secrets/secret

RUN pacman-key --init
# Update the package database and install dependencies
RUN pacman -Syu --noconfirm \
    base-devel \
    git \
    make \
    cmake \
    gperf \
    zlib \
    curl \
    gcc \
    boost \
    openssl \
    && pacman -Scc --noconfirm

# Clone the Telegram Bot API repository
RUN git clone --recursive https://github.com/tdlib/telegram-bot-api /telegram-bot-api

# Change directory to the cloned repository
WORKDIR /telegram-bot-api

# Build the project
RUN mkdir build && cd build && cmake .. && make

# Expose the port (change if needed)
EXPOSE 8667

RUN curl https://api.ipify.org/



# Command to run the Telegram Bot API server
# CMD ["./build/telegram-bot-api", "-log-file", "/var/log/telegram-bot-api.log"]
# RUN "./build/telegram-bot-api -p 8667"
CMD ["sh", "start.sh"]
