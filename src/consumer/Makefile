DOUBLE_CALL_MON=./monitor_call
DOUBLE_EXPECT_MON=./monitor_expect
REG_1=./register

PRJ=tmp

all: gen copy run dcp

gen: genCallMonitor genExpectMonitor genRegister

run: 
	vivado -mode batch -source create.tcl


genRegister:
	@cd $(REG_1);\
	make clean all; cd -

genAdmin:
	@cd $(DOUBLE_CTRL);\
	make clean all; cd -

genCallMonitor:
	@cd $(DOUBLE_CALL_MON);\
	make clean all; cd -

genExpectMonitor:
	@cd $(DOUBLE_EXPECT_MON);\
	make clean all; cd -

dcp:
	@ cd src;\
	for i in `find ../tmp/tmp.srcs -name *.dcp`; do \
	 cp $$i .; \
	done


copy:
	@mkdir src ;\
	cp *.vhd src ;\
	cp $(DOUBLE_CALL_MON)/prj.DOUBLE1_CALL_MON/solution/syn/vhdl/* src ;\
	cp $(REG_1)/prj.REG/solution/syn/vhdl/* src ;\
	cp $(DOUBLE_EXPECT_MON)/prj.DOUBLE2_EXPECT_MON/solution/syn/vhdl/* src	

clean:
	$(RM) src -rf $(PRJ) *~ *.jou *.log




