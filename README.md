# R2SPwmFanSpeedControl
R2S Fan口接风扇 温控调速脚本 for OpenWrt

注意：仅适用于风扇接FAN口的场景，USB风扇不适用

## R2S 外接风扇温控调速

### 1 手动操作部署：

#### 1.1 脚本替换路径

/etc/init.d/fa-rk3328-pwmfan

/usr/bin/start-rk3328-pwm-fan.sh

#### 1.2 手动执行

chmod +x /usr/bin/start-rk3328-pwm-fan.sh

chmod +x /etc/init.d/fa-rk3328-pwmfan

/etc/init.d/fa-rk3328-pwmfan enable

/etc/init.d/fa-rk3328-pwmfan start

### 2 自动化脚本部署

#### 2.1 下载本项目

wget https://github.com/jiangshuozz/R2SPwmFanSpeedControl/archive/refs/heads/main.zip -O R2SPwmFanSpeedControl

#### 2.2 进入到clone的文件夹，执行 sh ./one-key-deploy.sh 一键部署

unzip R2SPwmFanSpeedControl

cd ./R2SPwmFanSpeedControl-main

sh ./one-key-deploy.sh

### 3 构造测试场景

加CPU负载命令：cat /dev/urandom| gzip -9| gzip -d > /dev/null &

杀死测试进程命令：kill $(pgrep -f gzip)
