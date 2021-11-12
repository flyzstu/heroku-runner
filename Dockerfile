FROM alpine:latest
LABEL maintainer "wf09 <wf09@outlook.de>"

WORKDIR /root
ARG URL="https://github.com/flyzstu/heroku-runner"
ARG TOKEN="AWOMWP6NDNCLXM64N2CSTHTBRY2EG"
COPY stdin /root/
RUN set -ex \
	&& apk update \
	&& apk add --no-cache tzdata openssl ca-certificates curl \
	&& mkdir actions-runner && cd actions-runner \
	&& chmod +x ./configure.sh \
	&& ./configure.sh "${TARGETPLATFORM}" \ 
	&& curl -o actions-runner-linux-x64-2.284.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.284.0/actions-runner-linux-x64-2.284.0.tar.gz \
	&& echo "1ddfd7bbd3f2b8f5684a7d88d6ecb6de3cb2281a2a359543a018cc6e177067fc  actions-runner-linux-x64-2.284.0.tar.gz" | shasum -a 256 -c \
	&& tar xzf ./actions-runner-linux-x64-2.284.0.tar.gz \ 
	&& ./config.sh --url ${URL} --token ${TOKEN} < stdin

CMD /root/Xray/xray -config /root/config.json
