FROM alpine

ENV version=0.51.3

RUN apk add --no-cache curl \
	&& if [ $(apk --print-arch) == "aarch64" ]; then arch=arm64; else arch=amd64; fi \
	&& curl -fSL https://github.com/fatedier/frp/releases/download/v${version}/frp_${version}_linux_${arch}.tar.gz -o frp.tar.gz \
	&& tar -zxv -f frp.tar.gz \
	&& rm frp.tar.gz \
	&& mv frp_*_linux_*/frps .

VOLUME /frps.ini

CMD ["./frps", "-c", "/frps.ini"]
