#!/bin/bash

# 替换温控脚本文件
cp ./etc/init.d/fa-rk3328-pwmfan /etc/init.d/fa-rk3328-pwmfan
cp ./usr/bin/start-rk3328-pwm-fan.sh /usr/bin/start-rk3328-pwm-fan.sh
cp ./root/pwm-fan-status.sh /root/pwm-fan-status.sh
# 脚本添加执行权限
chmod +x /usr/bin/start-rk3328-pwm-fan.sh
chmod +x /etc/init.d/fa-rk3328-pwmfan
chmod +x /root/pwm-fan-status.sh
# 启动温控服务
/etc/init.d/fa-rk3328-pwmfan enable
/etc/init.d/fa-rk3328-pwmfan start
sleep 10s
/root/pwm-fan-status.sh
