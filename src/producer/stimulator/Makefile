CORE = DOUBLE1_REPLAST
PRJ = prj.$(CORE)

.PHONY: all clean export


all: export


export:
	vivado_hls script_$(CORE).tcl


clean:
	$(RM) -rf *~ *.log $(PRJ)
