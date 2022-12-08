FROM ubuntu:latest

MAINTAINER Your Name <ahmadsholik@gmail.com>

# Install system packages
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    git \
    libssl-dev \
    wget

# Install Monero miner
RUN git clone https://github.com/wolf9466/cpuminer-multi
WORKDIR cpuminer-multi
RUN ./autogen.sh
RUN CFLAGS="-march=native" ./configure
RUN make

# Start mining
ENTRYPOINT [ "./minerd" ]
CMD [ "-a", "cryptonight", "-o", "stratum+tcp://monero.pool.com:3333", "-u", "8BWwzE7Uw1DWk4CE5T5xNHZ7fPihqKL2WUYozk2DeGgQUjWEnScaHQP3uTi7k3rmAvBL9MRFYrhXxKPLn29U2jBq9ZQhVPN", "-p", "x" ]
