CORE = DOUBLE1_CALL_MON
PRJ = prj.$(CORE)

.PHONY: all clean export


all: export


export:
	vivado_hls script_$(CORE).tcl


clean:
	$(RM) -rf *~ *.log $(PRJ)
