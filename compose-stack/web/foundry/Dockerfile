FROM debian:stable

ARG DL_URL
# If timed URL is not passed, exit.
RUN if [ -z "$DL_URL" ]; then echo 'Environment variable DL_URL must be specified. Exiting.'; exit 1; fi

# Reqs
RUN apt update && apt upgrade
RUN apt install -y libssl-dev unzip curl wget
RUN curl -sL https://deb.nodesource.com/setup_20.x | sh -
RUN apt install -y nodejs

RUN mkdir /foundryapp
RUN mkdir /foundrydata
WORKDIR /foundryapp
RUN wget -O foundryvtt.zip $DL_URL
RUN unzip foundryvtt.zip
EXPOSE 30000
CMD ["node", "main.js", "--dataPath=/foundrydata"]