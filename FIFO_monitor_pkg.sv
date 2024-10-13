package FIFO_monitor_pkg;
import uvm_pkg::*;
import FIFO_seq_item_pkg::*;
`include "uvm_macros.svh"
class FIFO_monitor extends uvm_monitor;
    `uvm_component_utils(FIFO_monitor)
    virtual FIFO_interface FIFO_vif;
    FIFO_seq_item mon_seq_item;
    uvm_analysis_port #(FIFO_seq_item) mon_ap;
    function new(string name = "FIFO_monitor", uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon_ap = new("mon_ap",this);
    endfunction
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            mon_seq_item = FIFO_seq_item::type_id::create("mon_seq_item");
            @(negedge FIFO_vif.clk);
            mon_seq_item.rst_n       = FIFO_vif.rst_n      ;
            mon_seq_item.wr_en       = FIFO_vif.wr_en      ;
            mon_seq_item.rd_en       = FIFO_vif.rd_en      ;
            mon_seq_item.data_in     = FIFO_vif.data_in    ;
            mon_seq_item.full        = FIFO_vif.full       ;
            mon_seq_item.empty       = FIFO_vif.empty      ;
            mon_seq_item.almostfull  = FIFO_vif.almostfull ;
            mon_seq_item.almostempty = FIFO_vif.almostempty;
            mon_seq_item.wr_ack      = FIFO_vif.wr_ack     ;
            mon_seq_item.overflow    = FIFO_vif.overflow   ;
            mon_seq_item.underflow   = FIFO_vif.underflow  ;
            mon_seq_item.data_out    = FIFO_vif.data_out   ;
            mon_ap.write(mon_seq_item);
            `uvm_info("run_phase",mon_seq_item.convert2string(),UVM_HIGH)
        end
    endtask
endclass //FIFO_monitor extends uvm_monitor   
endpackage