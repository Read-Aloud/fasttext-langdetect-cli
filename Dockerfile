FROM debian:12 AS builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        g++ \
        git \
        make \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

RUN git clone --depth 1 https://github.com/facebookresearch/fastText.git .

RUN make CXXFLAGS="-pthread -std=c++17 -O2 -mtune=generic -funroll-loops"

FROM gcr.io/distroless/cc-debian12

WORKDIR /app

COPY --from=builder /src/fasttext /app/fasttext
COPY lid.176.ftz /app/lid.176.ftz

ENTRYPOINT ["/app/fasttext", "predict-prob", "/app/lid.176.ftz", "-", "3"]
