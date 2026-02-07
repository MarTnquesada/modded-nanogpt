FROM nvidia/cuda:12.6.2-cudnn-devel-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y --no-install-recommends curl git build-essential \
    && apt clean && rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

WORKDIR /modded-nanogpt
COPY pyproject.toml uv.lock .python-version ./

RUN uv sync --frozen

RUN uv pip install --pre torch --index-url https://download.pytorch.org/whl/nightly/cu126 --upgrade

CMD ["bash"]
ENTRYPOINT []
