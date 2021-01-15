#
# NAVIER-STOKES FINITE-DIFFERENCES SOLVER MAKE FILE
#
# ######################################################################
#
#brief      MAKEFILE
#
#history    Sergio Castiblanco
#+          13/01/2021
########################################################################
#
# SET COMPILER OPTIONS
#
FC = gfortran
#
# COMPILER FLAGS
#
FCFLAGS = -m64 -O2
#
# MOD FLAG FOR .mod FILES LOCATION
#
MODFLAG = -J
#
# MAIN DIRECTORY
#
NSDIR = $(CURDIR)
#
# DIRECTORIES FOR SOURCE, OBJECTS, MODULES AND BINARIES
#
SRCDIR = $(NSDIR)/src
OBJDIR = $(NSDIR)/obj
MODDIR = $(NSDIR)/mod
BINDIR = $(NSDIR)/bin
#
# COMPILER AND LINKER FLAGS - GNU FORTRAN
#
CFLAGS = -c -g -Warray-bounds -fbacktrace -fbounds-check -Wall $(FCFLAGS)
LFLAGS = -g -Warray-bounds -fbacktrace -fbounds-check -Wall $(FCFLAGS)
#
# FLAGS FOR MODULE DIRECTORY
#
CFLAGS += $(MODFLAG) $(MODDIR)
LFLAGS += $(MODFLAG) $(MODDIR)
#########################################################################
#
# SOURCE FILES
#
SRCMAIN = $(SRCDIR)/home_ns.f
SRCNUME = $(SRCDIR)/declarations_numerical.f
SRCPHYS = $(SRCDIR)/declarations_physic.f
SRCWRHE = $(SRCDIR)/write_headers.f
SRCPONS = $(SRCDIR)/point_ns.f
SRCDIFF = $(SRCDIR)/diffusion_matrix.f
#
# OBJECT FILES
#
OBJMAIN = $(OBJDIR)/home_ns.o
OBJNUME = $(OBJDIR)/declarations_numerical.o
OBJPHYS = $(OBJDIR)/declarations_physic.o
OBJWRHE = $(OBJDIR)/write_headers.o
OBJPONS = $(OBJDIR)/point_ns.o
OBJDIFF = $(OBJDIR)/diffusion_matrix.o
#
OBJECTS = $(OBJPHYS) $(OBJNUME) $(OBJWRHE) $(OBJMAIN) $(OBJPONS) /
    $(OBJDIFF)
#
#
# MODULE FILES
#
MODNUME = $(MODDIR)/declarations_numerical.mod
MODPHYS = $(MODDIR)/declarations_physic.mod
#
MODULES = $(MODPHYS) $(MODNUME)
#
#
# BINARY FILES
#
BINNSFD = $(BINDIR)/ns_df.out
#########################################################################
#
# !!!COMPILING!!!
#
$(BINNSFD): $(OBJECTS)
	    $(FC) $(LFLAGS) $(OBJECTS) -o $(BINNSFD)

$(OBJPHYS): $(SRCPHYS)
	    $(FC) $(CFLAGS) $(SRCPHYS) -o $(OBJPHYS)

$(OBJNUME): $(SRCNUME)
	    $(FC) $(CFLAGS) $(SRCNUME) -o $(OBJNUME)

$(OBJWRHE): $(SRCWRHE)
	    $(FC) $(CFLAGS) $(SRCWRHE) -o $(OBJWRHE)

$(OBJPONS): $(SRCPONS)
	    $(FC) $(CFLAGS) $(SRCPONS) -o $(OBJPONS)

$(OBJDIFF): $(SRCDIFF)
	    $(FC) $(CFLAGS) $(SRCDIFF) -o $(OBJDIFF)

$(OBJMAIN): $(MODULES) $(SRCMAIN)
	    $(FC) $(CFLAGS) $(SRCMAIN) -o $(OBJMAIN)

clean:
	    rm -f $(OBJECTS)
			rm -f $(MODULES)
			rm -f $(BINNSFD)
#END



