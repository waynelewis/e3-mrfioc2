# This the full setup for the Timing System with E3.
#
#require require,2.5.4
#require devlib2,2.9.0
require mrfioc2,2.2.0-rc1
#require iocStats,1856ef5
# require autosave, 5.8.0


epicsEnvSet("ENGINEER","")
epicsEnvSet("LOCATION","")

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES","10000000")

epicsEnvSet("IOC", "WAVEGENTRIG:")
epicsEnvSet("EVR", "EVR1")
epicsEnvSet("DEV1", "$(EVR):")

epicsEnvSet("MainEvtCODE" "14")
epicsEnvSet("HeartBeatEvtCODE"   "122")
epicsEnvSet("ESSEvtClockRate"  "88.0525")

mrmEvrSetupPCI("$(EVR)",  "01:00.0")
dbLoadRecords("evr-pcie-300dc-ess.db","EVR=$(EVR), SYS=$(IOC), D=$(DEV1), FEVT=$(ESSEvtClockRate)")


# needed with software timestamp source w/o RT thread scheduling
var evrMrmTimeNSOverflowThreshold 100000


# iocStats
#dbLoadRecords("iocAdminSoft.db", "IOC=$(IOC)IocStats")



iocInit()


#dbl > "${IOC}_PVs.list"

# Set delay compensation to 70 ns, needed to avoid timesptamp issue
dbpf $(IOC)$(DEV1)DC-Tgt-SP 70

dbpf $(IOC)$(DEV1)DlyGen0-Evt-Trig0-SP 122
dbpf $(IOC)$(DEV1)DlyGen0-Width-SP 1000
dbpf $(IOC)$(DEV1)OutFPUV02-Src-SP 0

