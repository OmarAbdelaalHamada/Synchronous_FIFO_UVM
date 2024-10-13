import uvm_pkg::*;
import FIFO_test_pkg::*;
`include "uvm_macros.svh"
module FIFO_top();
bit clk;
initial begin
    forever begin
        #5 clk = ~clk;
    end
end
    FIFO_interface FIFO_if(clk);
    FIFO DUT(.clk(clk), .rst_n(FIFO_if.rst_n),.data_in(FIFO_if.data_in), 
    .wr_en(FIFO_if.wr_en), .rd_en(FIFO_if.rd_en), .full(FIFO_if.full), .empty(FIFO_if.empty),
    .almostfull(FIFO_if.almostfull),.almostempty(FIFO_if.almostempty),.wr_ack(FIFO_if.wr_ack),
    .overflow(FIFO_if.overflow),.underflow(FIFO_if.underflow),.data_out(FIFO_if.data_out));
    bind FIFO FIFO_assertions Assertions_block(.clk(clk), .rst_n(FIFO_if.rst_n),.data_in(FIFO_if.data_in), 
    .wr_en(FIFO_if.wr_en), .rd_en(FIFO_if.rd_en), .full(FIFO_if.full), .empty(FIFO_if.empty),
    .almostfull(FIFO_if.almostfull),.almostempty(FIFO_if.almostempty),.wr_ack(FIFO_if.wr_ack),
    .overflow(FIFO_if.overflow),.underflow(FIFO_if.underflow),.data_out(FIFO_if.data_out));
initial begin
    uvm_config_db #(virtual FIFO_interface)::set(null,"uvm_test_top","FIFO_IF",FIFO_if);
    run_test("FIFO_test");
end
endmodule
