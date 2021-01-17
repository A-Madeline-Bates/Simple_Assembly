module use /eda/cadence/modules

module load course/COMSM1302


arm-none-eabi-as -g AS.s -o AS.o

arm-none-eabi-ld AS.o -o AS

qemu-arm -singlestep -g 1993 AS &

arm-none-eabi-gdb

file AS

target remote localhost:1993
