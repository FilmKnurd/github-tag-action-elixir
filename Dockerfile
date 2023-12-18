FROM node:18-alpine
LABEL "repository"="https://github.com/data-twister/github-tag-action-elixir"
LABEL "homepage"="https://github.com/data-twister/github-tag-action-elixir"
LABEL "maintainer"="mithereal"

RUN apk --no-cache add bash git curl jq && npm install -g semver

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
