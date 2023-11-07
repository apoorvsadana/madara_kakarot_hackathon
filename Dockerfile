FROM debian:12-slim AS final

RUN apt update
RUN apt install -y libpq-dev
RUN apt-get install -y procps
RUN apt-get install -y --no-install-recommends ca-certificates
RUN apt-get install -y --no-install-recommends wget

# Setup the binary
RUN wget https://github.com/keep-starknet-strange/madara/releases/download/v0.5.1/x86_64-unknown-linux-gnu-madara
RUN cp x86_64-unknown-linux-gnu-madara madara

# Setup madara
RUN chmod +x ./madara
RUN ./madara setup --chain=dev --base-path=/.madara --from-remote

EXPOSE 9944 9615 30333

# Start madarae
CMD ["./madara", "--chain=dev", "--base-path=/.madara", "--force-authoring","--alice","--rpc-external","--rpc-methods=unsafe"]