module Datapath (
    input logic clk, rst,
    input logic rs1_forward, rs2_forward,
    input logic [31:0] imm_value, ALU_result,
    input logic [31:0] CSRAddr, CSRDataIn,
    output logic [31:0] CSRDataOut,
    input logic CSRWriteEnable
);
    logic [31:0] CSRRegFile [0:31];
    logic [31:0] mepc;
    logic [31:0] PC; 

    always_ff @(posedge clk or posedge rst)
    begin
        if (rst)
            begin
            PC <= 32'h0;     
            mepc <= 32'h0; 
            interrupt <= 1'b0;

            // Reset CSR register file
            foreach (CSRRegFile[i])
                CSRRegFile[i] <= 32'h0;
        end

        else
            if (interrupt)
                mepc <= PC;
            if (CSRWriteEnable)
                CSRRegFile[CSRAddr] <= CSRDataIn;

            // Connect CSR register file output to writeback mux
            WritebackMuxInput <= (CSRReadEnable) ? CSRDataOut : ALU_result;

        end
    end
endmodule
