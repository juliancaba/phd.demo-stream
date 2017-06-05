PRJ=tmp


all: gen cpy run

gen: 
	@cd ../hls; make; cd -

cpy:
	@mkdir src
	cd src; ln -sf ../../hls/prj.TDD/solution/syn/vhdl/*.vhd .; \
	cd -; cp *.vhd src

run:
	vivado -mode batch -source create.tcl


clean:
	$(RM) -rf src $(PRJ) *~ *.jou *.log
