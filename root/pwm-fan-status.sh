#!/bin/bash

temp=$(cat /sys/class/thermal/thermal_zone0/temp)
temp_int=$[$temp/1000]
temp_float=$[$temp-$temp_int*1000]
pwm_period=$(cat /sys/class/pwm/pwmchip0/pwm0/period)
pwm_duty=$(cat /sys/class/pwm/pwmchip0/pwm0/duty_cycle)
fan_speed=$[100-$[${pwm_duty}*100/${pwm_period}]]
pid=$(pgrep -f pwm-fan.sh)

echo "------------------- Pwm Fan Status ----------------------"
echo "speed(%): $fan_speed"
echo "pwm_period: $pwm_period, pwm_duty: $pwm_duty, temp('C): $temp_int.$temp_float"
echo "current pid:"
echo $pid
