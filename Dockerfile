# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0

ARG GO_VER=1.20.4
ARG ALPINE_VER=3.18

FROM golang:${GO_VER}-alpine${ALPINE_VER} as builder

WORKDIR /
COPY . .

RUN go mod tidy
RUN go build -o external .

FROM alpine:${ALPINE_VER}

WORKDIR /

COPY --from=builder /external .

EXPOSE 9999
CMD ["external"]