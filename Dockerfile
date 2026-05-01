# syntax=docker/dockerfile:1.7

FROM nvcr.io/nvidia/pytorch:25.08-py3

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy
ENV UV_PYTHON_DOWNLOADS=never
ENV TORCH_FORCE_NO_WEIGHTS_ONLY_LOAD=1

COPY pyproject.toml README.md ./
COPY .project-root ./
COPY configs ./configs
COPY src ./src

RUN --mount=type=cache,target=/root/.cache/uv \
  uv pip install --system --break-system-packages -e .

CMD ["bash"]
