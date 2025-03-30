#!../../bin/linux-x86_64/AJARF

#- You may have to change AJARF to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/AJARF.dbd"
AJARF_registerRecordDeviceDriver pdbbase

## Load record instances
epicsEnvSet ("STREAM_PROTOCOL_PATH", "${TOP}/AJARFApp/Db")
epicsEnvSet ("PREFIX", "SLAC:AJA:")
epicsEnvSet ("PORT", "serial8")

#- Set this to see messages from mySub
#var mySubDebug 1
drvAsynIPPortConfigure("serial8", "/dev/ttyUSB0", 0, 0, 0)
asynSetOption("serial8",0,"baud","38400")
asynSetOption("serial8",0,"bits","8")
asynSetOption("serial8",0,"stop","1")
asynSetOption("serial8",0,"parity","none")
asynSetOption("serial8",0,"crtscts","N")

#- Run this to trace the stages of iocInit
#traceIocInit

dbLoadRecords("${TOP}/AJARFApp/Db/AJARF.db","P=$(PREFIX),PORT=serial8")
dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db", "P=SLAC:AJA:")
dbLoadRecords("$(ASYN)/db/asynRecord.db", "P=$(PREFIX),R=asyn1,PORT=serial8,ADDR=0,IMAX=80,OMAX=80")

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncExample, "user=quan"
