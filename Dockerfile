ARG ELIXIR_VERSION=1.15.4
ARG OTP_VERSION=26.0.2
ARG DEBIAN_VERSION=bullseye-20230612-slim

ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"
FROM ${BUILDER_IMAGE} as builder

LABEL "repository"="https://github.com/data-twister/github-tag-action-elixir"
LABEL "homepage"="https://github.com/data-twister/github-tag-action-elixir"
LABEL "maintainer"="mithereal"

RUN apt-get update -y && apt-get install -y build-essential git npm bash curl jq\
    && apt-get clean && rm -f /var/lib/apt/lists/*_* && npm install -g semver

RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
