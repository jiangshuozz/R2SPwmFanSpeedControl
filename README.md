# R2SPwmFanSpeedControl
R2S Fan口接风扇 温控调速脚本 for OpenWrt

注意：仅适用于风扇接FAN口的场景，USB风扇不适用

## R2S 外接风扇温控调速

(安装方式三选一)

### 1 全自动安装

curl https://raw.githubusercontent.com/jiangshuozz/R2SPwmFanSpeedControl/main/pwmfan-install -o install && chmod +x install && ./install

### 2 手动操作部署

#### 2.1 脚本替换路径

/etc/init.d/fa-rk3328-pwmfan

/usr/bin/start-rk3328-pwm-fan.sh

#### 2.2 手动执行

chmod +x /usr/bin/start-rk3328-pwm-fan.sh

chmod +x /etc/init.d/fa-rk3328-pwmfan

/etc/init.d/fa-rk3328-pwmfan enable

/etc/init.d/fa-rk3328-pwmfan start

### 3 自动化脚本部署

#### 3.1 下载本项目

wget https://github.com/jiangshuozz/R2SPwmFanSpeedControl/archive/refs/heads/main.zip -O R2SPwmFanSpeedControl

#### 3.2 进入到clone的文件夹，执行 sh ./one-key-deploy.sh 一键部署

unzip R2SPwmFanSpeedControl

cd ./R2SPwmFanSpeedControl-main

sh ./one-key-deploy.sh

## 构造测试场景(有兴趣可选)

加CPU负载命令：cat /dev/urandom| gzip -9| gzip -d > /dev/null &

杀死测试进程命令：kill $(pgrep -f gzip)

温控状态查询命令：/root/pwm-fan-status.sh
