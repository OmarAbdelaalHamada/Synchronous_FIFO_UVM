package FIFO_test_pkg;
import uvm_pkg::*;
import FIFO_env_pkg::*;
import FIFO_config_obj_pkg::*;
import reset_sequence_pkg::*;
import write_only_sequence_pkg::*;
import read_only_sequence_pkg::*; 
import write_read_sequence_pkg::*;
`include "uvm_macros.svh"
class FIFO_test extends uvm_test;
    `uvm_component_utils(FIFO_test)
    virtual FIFO_interface FIFO_vif;
    FIFO_env            env;
    FIFO_config_obj     FIFO_cfg;
    reset_sequence       rst_seq;
    write_only_sequence wr_seq;
    read_only_sequence  rd_seq;
    write_read_sequence wr_rd_seq;
    function new(string name ="FIFO_test", uvm_component parent = null);
        super.new(name,parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env       = FIFO_env::type_id::create("env",this);
        FIFO_cfg  = FIFO_config_obj::type_id::create("FIFO_cfg",this);
        rst_seq   = reset_sequence::type_id::create("rst_seq",this);
        wr_seq    = write_only_sequence::type_id::create("wr_seq",this);
        rd_seq    = read_only_sequence::type_id::create("rd_seq",this);
        wr_rd_seq = write_read_sequence::type_id::create("wr_rd_seq",this);
        if(!uvm_config_db #(virtual FIFO_interface)::get(this,"","FIFO_IF",FIFO_cfg.FIFO_vif))
            `uvm_fatal("build_phase","Unable to get this virtual interface from FIFO_cfg")
        uvm_config_db #(FIFO_config_obj)::set(this,"*","DRIVER_IF",FIFO_cfg);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        `uvm_info("run_phase","reset_sequece started",UVM_LOW)
        rst_seq.start(env.agt.sqr);
        `uvm_info("run_phase","reset_sequece finished",UVM_LOW)
        `uvm_info("run_phase","write_only_sequence started",UVM_LOW)
        wr_seq.start(env.agt.sqr);
        `uvm_info("run_phase","write_only_sequence finished",UVM_LOW)
        `uvm_info("run_phase","read_only_sequence started",UVM_LOW)
        rd_seq.start(env.agt.sqr);
        `uvm_info("run_phase","read_only_sequence finished",UVM_LOW)
        `uvm_info("run_phase","write_read_sequence started",UVM_LOW)
        wr_rd_seq.start(env.agt.sqr);
        `uvm_info("run_phase","write_read_sequence finished",UVM_LOW)
        phase.drop_objection(this);
    endtask
endclass //FIFO_test extends uvm_test
endpackage