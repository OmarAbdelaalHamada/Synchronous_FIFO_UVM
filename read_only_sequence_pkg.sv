package read_only_sequence_pkg;
import uvm_pkg::*;
import FIFO_seq_item_pkg::*;
`include "uvm_macros.svh"
class read_only_sequence extends uvm_sequence #(FIFO_seq_item);
`uvm_object_utils(read_only_sequence)
    function new(string name = "read_only_sequence");
        super.new(name);
    endfunction //new()
    virtual task body();
        repeat(10) begin
            FIFO_seq_item seq_item;
            seq_item = FIFO_seq_item::type_id::create("seq_item");
            start_item(seq_item);
                randomization: assert (seq_item.randomize())
                else $error("Assertion randomization failed!"); 
                seq_item.rst_n = 1;
                seq_item.wr_en = 0;
                seq_item.rd_en = 1;
            finish_item(seq_item);
        end 
    endtask
endclass //read_only_sequence extends uvm_sequence
endpackage