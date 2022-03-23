TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += AJARFSupport

# Compile and add code to the support library
AJARFSupport_SRCS += xxxRecord.c
AJARFSupport_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
AJARFSupport_SRCS += dbSubExample.c
AJARFSupport_SRCS += devAJARFVersion.c
AJARFSupport_SRCS += AJARFHello.c
AJARFSupport_SRCS += initTrace.c

AJARFSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = AJARFVersion.h
# Macro name
GENVERSIONMACRO = AJARFVERSION

# Build the IOC application
PROD_IOC = AJARF

# AJARF.dbd will be created and installed
DBD += AJARF.dbd

# AJARF.dbd will include these files:
AJARF_DBD += base.dbd
AJARF_DBD += xxxSupport.dbd
AJARF_DBD += dbSubExample.dbd
AJARF_DBD += devAJARFVersion.dbd
AJARF_DBD += AJARFHello.dbd
AJARF_DBD += initTrace.dbd
AJARF_DBD += asyn.dbd
AJARF_DBD += drvAsynSerialPort.dbd
AJARF_DBD += drvAsynIPPort.dbd
AJARF_DBD += calc.dbd
AJARF_DBD += stream-scalcout.dbd
AJARF_DBD += stream.dbd
AJARF_DBD += as.dbd
AJARF_DBD += asSupport.dbd
# AJARF_registerRecordDeviceDriver.cpp derives from AJARF.dbd
AJARF_SRCS += AJARF_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
AJARF_SRCS_DEFAULT += AJARFMain.cpp
AJARF_SRCS_vxWorks += -nil-

# Link in the code from our support library
AJARF_LIBS += AJARFSupport
AJARF_LIBS += asyn
AJARF_LIBS += calc
AJARF_LIBS += autosave
AJARF_LIBS += stream

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into AJARFSupport
    sncExample_SNCFLAGS += +r
    AJARF_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    AJARFSupport_SRCS += sncExample.stt
    AJARFSupport_LIBS += seq pv
    AJARF_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    AJARF_LIBS += qsrv
    AJARF_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    AJARF_DBD += PVAServerRegister.dbd
    AJARF_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
AJARF_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devAJARFVersion$(DEP): $(COMMON_DIR)/$(GENVERSION)
