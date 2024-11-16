#!/bin/bash

# 创建自定义网络（如果尚未创建）



# 获取当前时间戳
start_time=$(date +%s)

# 计算 4 小时 55 分钟后的时间戳
end_time=$((start_time + 5*60*60 + 55*60))
# end_time=$((start_time + 5*60))

# 循环检查时间，直到当前时间超过结束时间
while [ $(date +%s) -lt $end_time ]; do
    # 每隔一段时间检查一次，可以调整 sleep 的时间间隔
    sleep 60
done

# 当时间超过 4 小时 55 分钟后，停止 Docker 容器
# sudo docker stop chat
sudo docker stop cf 
sudo docker stop xui 
docker commit xui xui:latest
docker save -o xui.tar xui:latest
tar -zcvf xui_img.tar.gz xui.tar
sudo docker rm cf xui




