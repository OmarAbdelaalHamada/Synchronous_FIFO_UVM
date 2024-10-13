package reset_sequence_pkg;
import uvm_pkg::*;
import FIFO_seq_item_pkg::*;
`include "uvm_macros.svh"
class reset_sequence extends uvm_sequence #(FIFO_seq_item);
`uvm_object_utils(reset_sequence)
    function new(string name = "reset_sequence");
        super.new(name);
    endfunction //new()
    virtual task body();
        FIFO_seq_item seq_item;
        seq_item = FIFO_seq_item::type_id::create("seq_item");
        start_item(seq_item);
            seq_item.rst_n   = 0;
            seq_item.wr_en   = 0;
            seq_item.rd_en   = 0;
            seq_item.data_in = 0;
        finish_item(seq_item);
    endtask
endclass //reset_sequence extends uvm_sequence
endpackage