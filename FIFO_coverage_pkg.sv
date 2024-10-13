package FIFO_coverage_pkg;
import uvm_pkg::*;
import FIFO_seq_item_pkg::*;
`include "uvm_macros.svh"
class FIFO_coverage extends uvm_component;
    `uvm_component_utils(FIFO_coverage)
    uvm_analysis_export #(FIFO_seq_item) cov_export;
    uvm_tlm_analysis_fifo #(FIFO_seq_item) cov_fifo;
    FIFO_seq_item cov_seq_item;
    //Covergroup :        
        covergroup write_read_covgrp;
            //coverpoints :
            wr_en_lable                 : coverpoint cov_seq_item.wr_en;
            rd_en_lable                 : coverpoint cov_seq_item.rd_en;
            full_lable                  : coverpoint cov_seq_item.full;
            almostfull_lable            : coverpoint cov_seq_item.almostfull;
            overflow_lable              : coverpoint cov_seq_item.overflow;
            wr_ack_lable                : coverpoint cov_seq_item.wr_ack;
            empty_lable                 : coverpoint cov_seq_item.empty;
            almostempty_lable           : coverpoint cov_seq_item.almostempty;
            underflow_lable             : coverpoint cov_seq_item.underflow;
            //crosses :
            write_enable_full_bin       : cross wr_en_lable,full_lable;
            write_enable_almostfull_bin : cross wr_en_lable,almostfull_lable;
            write_enable_overflow_bin   : cross wr_en_lable,overflow_lable
            {
                ignore_bins write_0_overflow_1 = (binsof(wr_en_lable) intersect {0} &&
                binsof(overflow_lable) intersect {1});
            }
            write_enable_wr_ack_bin     : cross wr_en_lable,wr_ack_lable
            {
                ignore_bins write_0_wr_ack_1 = (binsof(wr_en_lable) intersect {0} &&
                binsof(wr_ack_lable) intersect {1});
            }
            read_enable_empty_bin       : cross rd_en_lable,empty_lable;
            read_enable_almostempty_bin : cross rd_en_lable,almostempty_lable;
            read_enable_underflow_bin   : cross rd_en_lable,underflow_lable
            {
                ignore_bins read_0_underflow_1 = (binsof(rd_en_lable) intersect {0} &&
                binsof(underflow_lable) intersect {1});
            }
        endgroup

    function new(string name = "FIFO_coverage",uvm_component parent);
        super.new(name,parent);
        write_read_covgrp = new();
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cov_export = new("cov_export",this);
        cov_fifo   = new("cov_fifo",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        cov_export.connect(cov_fifo.analysis_export);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            cov_fifo.get(cov_seq_item);
            write_read_covgrp.sample();
        end
    endtask
endclass //FIFO_coverage extends uvm_component
endpackage