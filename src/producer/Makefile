DOUBLE_MON=./monitor_call
REP_LAST=./stimulator

PRJ=tmp

VERSION=2015


all: gen copy 

gen: genMonitor genRepLast

run: create_$(VERSION).tcl 
	vivado -mode batch -source $^

genMonitor:
	@cd $(DOUBLE_MON);\
	make clean all; cd -

genRepLast:
	@cd $(REP_LAST);\
	make clean all; cd -

copy:
	@mkdir src ;\
	cp *.vhd src ;\
	cp $(DOUBLE_MON)/prj.DOUBLE1_CALL_MON/solution/syn/vhdl/* src ;\
	cp $(REP_LAST)/prj.DOUBLE1_REPLAST/solution/syn/vhdl/* src 

clean:
	$(RM) src -rf $(PRJ) *~ *.jou *.log




