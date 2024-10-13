import shared_pkg::*;
module FIFO_assertions (data_in, wr_en, rd_en, clk, rst_n, full, empty, almostfull, almostempty, wr_ack, overflow, underflow, data_out);
input [FIFO_WIDTH-1:0] data_in;
input clk, rst_n, wr_en, rd_en;
input  [FIFO_WIDTH-1:0] data_out;
input  wr_ack, overflow;
input full, empty, almostfull, almostempty, underflow;
always_comb begin
	if (!FIFO_if.rst_n) begin
		reset_assertion: assert final((!DUT.wr_ptr) && (!DUT.rd_ptr) &&
		(!DUT.count)); 
	end
end

always_comb begin
	full_assertion: assert ((DUT.count == FIFO_DEPTH) === FIFO_if.full);
	almostfull_assertion: assert final(FIFO_if.almostfull == (DUT.count == FIFO_DEPTH-1));
	empty_assertion: assert final(FIFO_if.empty == (DUT.count == 0));	
	almostempty_assertion: assert final(FIFO_if.almostempty == (DUT.count == 1));
end
//check on overflow :
property overflow_test;
	@(posedge FIFO_if.clk) disable iff(~FIFO_if.rst_n)
	(FIFO_if.full && FIFO_if.wr_en)  |=> FIFO_if.overflow;
endproperty
assert property(overflow_test)
	else $error("Assertion overflow_test failed!");
cover property(overflow_test);
//check on underflow :
property underflow_test;
	@(posedge FIFO_if.clk) disable iff(~FIFO_if.rst_n)
	(FIFO_if.empty && FIFO_if.rd_en)  |=> FIFO_if.underflow;
endproperty
assert property(underflow_test)
	else $error("Assertion underflow_test failed!");
cover property(underflow_test);
//check on wr_ack :
property wr_ack_test ;
	@(posedge FIFO_if.clk) disable iff(~FIFO_if.rst_n)
	(FIFO_if.wr_en && DUT.count < FIFO_DEPTH)  |=> FIFO_if.wr_ack;
endproperty
assert property(wr_ack_test)
	else $error("Assertion wr_ack_test failed!");
cover property(wr_ack_test);
// Property for write pointer assertion
property write_ptr_test;
	@(posedge FIFO_if.clk) disable iff(!FIFO_if.rst_n) 
	(FIFO_if.wr_en && DUT.count < FIFO_DEPTH) |=>(DUT.wr_ptr == $past(DUT.wr_ptr + 1'b1));
endproperty
assert property(write_ptr_test)
	else $error("Assertion write_ptr_test failed!");
cover property(write_ptr_test);
// Property for read pointer assertion
property read_ptr_test;
	@(posedge FIFO_if.clk) disable iff(!FIFO_if.rst_n) 
	(FIFO_if.rd_en && DUT.count != 0) |=>(DUT.rd_ptr == $past(DUT.rd_ptr + 1'b1));
endproperty
assert property(read_ptr_test)
	else $error("Assertion read_ptr_test failed!");
cover property(read_ptr_test);
endmodule