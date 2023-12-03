module Datapath (
    input logic clk, rst,
    input logic rs1_forward, rs2_forward,
    input logic [31:0] imm_value, ALU_result,
    input logic [31:0] CSRAddr, CSRDataIn,
    output logic [31:0] CSRDataOut,
    input logic CSRWriteEnable
);
    // Assuming memory_type is a type representing a register file
    logic [31:0] CSRRegFile [0:31];

    always_ff @(posedge clk or posedge rst)
    begin
        if (rst)
            // Reset logic
            // ...
        else
            // Existing datapath logic
            // ...

            // CSR register file logic
            if (CSRWriteEnable)
                CSRRegFile[CSRAddr] <= CSRDataIn;

            // Connect CSR register file output to writeback mux
            WritebackMuxInput <= (CSRReadEnable) ? CSRDataOut : ALU_result; // Modify as per your mux structure
        end
    end
endmodule
