DUT =../DUT
CTRL = ../ctrlAdmin
CONSUMER = ../consumer
PRODUCER = ../producer


PRJ=tmp

all: genDUT genCONSUMER genPRODUCER genADMIN copy run dcp


run: create.tcl 
	vivado -mode batch -source create.tcl

genDUT:
	@cd $(DUT)/hls;\
	make clean all; cd -

genADMIN:
	@cd $(CTRL);\
	make clean all; cd -

genCONSUMER:
	@cd $(CONSUMER);\
	make clean gen copy; cd -

genPRODUCER:
	@cd $(PRODUCER);\
	make clean gen copy; cd -

dcp:
	@cd src;\
	for i in `find ../tmp/tmp.srcs -name *.dcp`; do \
	 ln -sf $$i; \
	done

copy:
	@mkdir src ;\
	cp $(DUT)/hls/prj.TDD/solution/syn/vhdl/* src ;\
	cp $(CTRL)/prj.CTRL/solution/syn/vhdl/* src ;\
	cp $(CONSUMER)/src/* src ;\
	cp $(PRODUCER)/src/* src ;\
	$(RM) -rf src/*_tb.vhd ;\
	cp *.vhd src 

clean:
	$(RM) src -rf $(PRJ) *~ *.jou *.log




