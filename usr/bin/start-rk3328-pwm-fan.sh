#!/bin/bash
# /etc/init.d/fa-rk3328-pwmfan
PWM_PERIOD=100000000 # affect the resolution of PWM
ENTER_SLEEP_TIME=5s
EXIT_SLEEP_TIME=120s

if [ ! -d /sys/class/pwm/pwmchip0 ]; then
    echo "this model does not support pwm."
    exit 1
fi

if [ ! -d /sys/class/pwm/pwmchip0/pwm0 ]; then
    echo -n 0 > /sys/class/pwm/pwmchip0/export
fi
sleep 1
while [ ! -d /sys/class/pwm/pwmchip0/pwm0 ];
do
    sleep 1
done
ISENABLE=`cat /sys/class/pwm/pwmchip0/pwm0/enable`
if [ $ISENABLE -eq 1 ]; then
    echo -n 0 > /sys/class/pwm/pwmchip0/pwm0/enable
fi
echo -n $PWM_PERIOD > /sys/class/pwm/pwmchip0/pwm0/period
echo -n 1 > /sys/class/pwm/pwmchip0/pwm0/enable

# max speed run 5s
echo -n 0 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
sleep 5
echo -n $PWM_PERIOD > /sys/class/pwm/pwmchip0/pwm0/duty_cycle

declare -a CpuTemps=(75000 63000 58000 54000 52000 42000)
declare -a Percents=(100 95 85 75 65 55)
CpuTempsLen=$[${#CpuTemps[@]}-1]
echo CpuTemps: ${CpuTemps[*]}
echo Percents: ${Percents[*]}
echo Len: $CpuTempsLen

DefaultDuty=$PWM_PERIOD
DefaultPercents=0
PeakFilterThld=10
PeakCnt=0
SleepTime=$ENTER_SLEEP_TIME

while true
do
	temp=$(cat /sys/class/thermal/thermal_zone0/temp)
	INDEX=0
	FOUNDTEMP=0
	DUTY=$DefaultDuty
	PERCENT=$DefaultPercents
	
	for i in $(seq 0 $CpuTempsLen); do
		if [ $temp -gt ${CpuTemps[$i]} ]; then
			INDEX=$i
      PeakCnt=$((${PeakCnt}+1))
      FOUNDTEMP=1
			break
		fi	
	done
  if [ ${FOUNDTEMP} == 0 ]; then
    PeakCnt=0
    SleepTime=$ENTER_SLEEP_TIME
	fi
  echo "PeakFilterThld: $PeakFilterThld, PeakCnt: ${PeakCnt}"
  if [ ${PeakCnt} -gt ${PeakFilterThld} ]; then
		PERCENT=${Percents[$i]}
    DUTY=$[${PWM_PERIOD}*$[100-${PERCENT}]/100] # DUTY=${PwmDutyCycles[$i]}
    PeakCnt=$((${PeakCnt}-1))
    SleepTime=$EXIT_SLEEP_TIME
	fi
  echo "PeakFilterThld: $PeakFilterThld, PeakCnt: ${PeakCnt}, SleepTime: $SleepTime"
	echo -n $DUTY > /sys/class/pwm/pwmchip0/pwm0/duty_cycle;

  echo "temp: $temp, duty: $DUTY, ${PERCENT}%"
  # cat /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq

	sleep $SleepTime;
done
