FROM ubuntu

WORKDIR /usr/src/app

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt update && apt install -y git wget curl && \
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && \
    source ~/.nvm/nvm.sh
    
RUN source ~/.nvm/nvm.sh; \
    nvm install node && \
    npm i -g yarn && \
    npm i -g serve 

COPY --from=ipfs/kubo:v0.14.0 /usr/local/bin/ipfs /usr/local/bin/ipfs

COPY entrypoint.sh /usr/local/bin

ENTRYPOINT entrypoint.sh
