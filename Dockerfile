FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

WORKDIR /app

# 显示暴露端口
EXPOSE 7860

ENV PYTHONUNBUFFERED=1

# 安装系统依赖
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        pkg-config \
        libzstd-dev \
        libfreetype6-dev \
        libgl1 \
        libglib2.0-0 \
        libxext6 \
        libsm6 \
        libxrender1 && \
    rm -rf /var/lib/apt/lists/*

# 拷贝整个项目（推荐整体复制）
COPY . .

# 安装构建工具
RUN uv pip install --system hatchling

# 安装本地项目（包含 pyproject.toml）
RUN uv pip install --system -e .

# 设置启动命令（可改为你实际入口）
CMD ["pdf2zh", "-i"]
