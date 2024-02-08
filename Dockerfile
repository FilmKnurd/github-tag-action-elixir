ARG ELIXIR_VERSION=1.13.3
ARG OTP_VERSION=25.0.3
ARG DEBIAN_VERSION=bullseye-20210902-slim

ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"
FROM ${BUILDER_IMAGE}

LABEL "repository"="https://github.com/data-twister/github-tag-action-elixir"
LABEL "homepage"="https://github.com/data-twister/github-tag-action-elixir"
LABEL "maintainer"="mithereal"

RUN apt-get update -y && apt-get install -y build-essential git npm bash curl jq\
    && apt-get clean && rm -f /var/lib/apt/lists/*_* && npm install -g semver

RUN mix local.hex --force && \
    mix local.rebar --force

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
