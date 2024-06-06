#!/bin/bash

# 启动 Docker 容器
sudo docker run  -itd --name chat -v $GITHUB_WORKSPACE/:/models -p 8000:8000 ghcr.io/ggerganov/llama.cpp:server -m /models/MiniCPM-2B-dpo-fp16-gguf.gguf --port 8000 --host 0.0.0.0 -n 1024
sudo docker run -itd --name cf cloudflare/cloudflared:latest tunnel --no-autoupdate run --token eyJhIjoiYWZjODQ0MzQ0YzNhZGE5ODM3MzgzYjFlNDQzYjg3YWEiLCJ0IjoiMTQyZDMzMWMtYWUzZC00ZGJkLThhYzktZDJlNzY2YTAxYmFiIiwicyI6Ill6YzRNRGhpWVRBdE0yRmpOQzAwWW1RNUxUbGhOVFF0WXpSbE16WmlOMlF5TXpOaiJ9
# 获取当前时间戳
start_time=$(date +%s)

# 计算 4 小时 55 分钟后的时间戳
end_time=$((start_time + 2*60*60 + 55*60))

# 循环检查时间，直到当前时间超过结束时间
while [ $(date +%s) -lt $end_time ]; do
    # 每隔一段时间检查一次，可以调整 sleep 的时间间隔
    sleep 60
done

# 当时间超过 4 小时 55 分钟后，停止 Docker 容器
sudo docker stop chat
sudo docker stop cf
sudo docker rm chat cf




