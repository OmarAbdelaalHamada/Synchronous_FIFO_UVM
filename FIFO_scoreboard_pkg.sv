package FIFO_scoreboard_pkg;
import uvm_pkg::*;
import FIFO_seq_item_pkg::*; 
import shared_pkg::*; 
`include "uvm_macros.svh"
class FIFO_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(FIFO_scoreboard)
    uvm_analysis_export #(FIFO_seq_item) sb_export;
    uvm_tlm_analysis_fifo #(FIFO_seq_item) sb_fifo;
    FIFO_seq_item sb_seq_item;
    logic [FIFO_WIDTH-1:0] data_out_ref;
    reg[15:0] fifo [$];
    logic [3:0] queue_size;
    integer correct_counter = 0;
    integer error_counter   = 0;
    function new(string name = "FIFO_scoreboard",uvm_component parent);
        super.new(name,parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sb_export = new("sb_export",this);
        sb_fifo   = new("sb_fifo",this);
    endfunction //build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        sb_export.connect(sb_fifo.analysis_export);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            sb_fifo.get(sb_seq_item);
            ref_model(sb_seq_item);
            if(sb_seq_item.data_out === data_out_ref) begin
                `uvm_info("run_phase",$sformatf("Correct FIFO out : %s",sb_seq_item.convert2string()),UVM_HIGH);
                correct_counter++;
            end
            else begin
                `uvm_info("run_phase",$sformatf("Wrong FIFO out , Transactions  : %s while out_ref = 0b%0b",sb_seq_item.convert2string(),data_out_ref),UVM_MEDIUM);
                error_counter++;
            end
        end
    endtask

    task ref_model(FIFO_seq_item seq_item_ckeck);
        queue_size = fifo.size();
        if(!seq_item_ckeck.rst_n) begin
            for(integer i = 0;i < queue_size; i++) begin
                fifo.pop_front();
            end
            queue_size = fifo.size();
        end
        else begin
            queue_size = fifo.size();
            case ({seq_item_ckeck.wr_en,seq_item_ckeck.rd_en})
                2'b00: begin
                    data_out_ref = data_out_ref;
                end
                2'b10:
                begin
                if(queue_size != 8)
                    fifo.push_back(seq_item_ckeck.data_in);
                    data_out_ref = data_out_ref;
                end
                2'b01:
                begin
                    if(queue_size!= 0)
                        data_out_ref = fifo.pop_front();
                end
                2'b11:
                begin
                    if(queue_size == 0)begin
                        fifo.push_back(seq_item_ckeck.data_in);
                        data_out_ref <= data_out_ref;
                    end
                    else if (queue_size == 8)
                        data_out_ref = fifo.pop_front();
                    else begin
                        data_out_ref = fifo.pop_front();
                        fifo.push_back(seq_item_ckeck.data_in);
                    end
                end
            endcase
        end
    endtask
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("report_phase",$sformatf("Total successful transactions = %0d",correct_counter),UVM_MEDIUM);
        `uvm_info("report_phase",$sformatf("Total failed transactions = %0d",error_counter),UVM_MEDIUM);
    endfunction
endclass //FIFO_scoreboard extends uvm_scoreboard
endpackage