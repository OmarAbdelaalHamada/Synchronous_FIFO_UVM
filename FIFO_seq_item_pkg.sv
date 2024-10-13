package FIFO_seq_item_pkg;
import uvm_pkg::*;
import shared_pkg::*;
`include "uvm_macros.svh"
class FIFO_seq_item extends uvm_sequence_item;
`uvm_object_utils(FIFO_seq_item)
    rand logic [FIFO_WIDTH-1:0] data_in;
    rand logic rst_n, wr_en, rd_en;
    logic [FIFO_WIDTH-1:0] data_out;
    logic wr_ack, overflow;
    logic full, empty, almostfull, almostempty, underflow;
    function new(string name = "FIFO_seq_item");
        super.new(name);
    endfunction //new()
    function string convert2string();
        return $sformatf("%s rst_n = 0b%0b ,wr_en = 0b%0b ,rd_en = 0b%0b ,data_in = 0b%0b",super.convert2string(),rst_n,wr_en,rd_en,data_in); 
        endfunction
    function string convert2string_stimulus();
        return $sformatf("rst_n = 0b%0b ,wr_en = 0b%0b ,rd_en = 0b%0b ,data_in = 0b%0b",rst_n,wr_en,rd_en,data_in); 
    endfunction
    constraint reset_constraint{
        rst_n dist {
        0:/5,
        1:/95
        };
    }
    constraint write_en_constraint{
        wr_en dist {
        1:/WR_EN_ON_DIST,
        0:/(100 - WR_EN_ON_DIST)
        };
    }
    constraint read_en_constraint{
        rd_en dist {
        1:/RD_EN_ON_DIST,
        0:/(100 - RD_EN_ON_DIST)
        };
    }

endclass //FIFO_seq_item extends uvm_sequence_item   
endpackage