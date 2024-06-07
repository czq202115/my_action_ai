#!/bin/bash

# 创建自定义网络（如果尚未创建）
network_name="my_custom_network"
subnet="172.18.0.0/16"

docker network inspect $network_name > /dev/null 2>&1
if [ $? -ne 0 ]; then
    docker network create --subnet=$subnet $network_name
fi

# 指定容器的静态IP地址
static_ip1="172.18.0.10"
static_ip2="172.18.0.11"

# 启动 Docker 容器
sudo docker run -itd --name cf --net $network_name --ip $static_ip1 cloudflare/cloudflared:latest tunnel --no-autoupdate run --token eyJhIjoiYWZjODQ0MzQ0YzNhZGE5ODM3MzgzYjFlNDQzYjg3YWEiLCJ0IjoiMTQyZDMzMWMtYWUzZC00ZGJkLThhYzktZDJlNzY2YTAxYmFiIiwicyI6Ill6YzRNRGhpWVRBdE0yRmpOQzAwWW1RNUxUbGhOVFF0WXpSbE16WmlOMlF5TXpOaiJ9
sudo docker run -itd --name chat --net $network_name --ip $static_ip2 -v $GITHUB_WORKSPACE/models:/models  my-image:latest -m /models/MiniCPM-2B-dpo-fp16-gguf/MiniCPM-2B-dpo-fp16-gguf.gguf --port 8000 --host 0.0.0.0 -n 1024
sudo docker ps -a
ip add
sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' cf
sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' chat
cd models
ls
cd MiniCPM-2B-dpo-fp16-gguf
ls


# 获取当前时间戳
start_time=$(date +%s)

# 计算 4 小时 55 分钟后的时间戳
end_time=$((start_time + 5*60*60 + 55*60))

# 循环检查时间，直到当前时间超过结束时间
while [ $(date +%s) -lt $end_time ]; do
    # 每隔一段时间检查一次，可以调整 sleep 的时间间隔
    sleep 60
done

# 当时间超过 4 小时 55 分钟后，停止 Docker 容器
sudo docker stop chat
sudo docker stop cf 
sudo docker rm chat cf




