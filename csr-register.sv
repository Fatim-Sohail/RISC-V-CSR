module CSRRegisterFile (
    input logic [11:0] CSRAddr,
    input logic [31:0] CSRWriteData,
    input logic CSRWriteEnable,
    input logic CSRReadEnable,
    output logic [31:0] CSRReadData,
    output logic [31:0] ExceptionPC
);
    // CSR register file for machine mode
    logic [31:0] mip, mie, mstatus, mcause, mtvec, mepc;

    always_ff @(posedge clk or posedge rst)
    begin
        if (rst)
            // Reset logic
            // ...
        else
            // CSR register file logic
            if (CSRWriteEnable)
            begin
                case (CSRAddr)
                    12'h300: mip <= CSRWriteData;    // Machine Interrupt Pending
                    12'h304: mie <= CSRWriteData;    // Machine Interrupt Enable
                    12'h300: mstatus <= CSRWriteData; // Machine Status
                    12'h342: mcause <= CSRWriteData;  // Machine Exception Cause
                    12'h341: mtvec <= CSRWriteData;  // Machine Trap-Vector Base Address
                    12'h341: mepc <= CSRWriteData;   // Machine Exception Program Counter
                    default: // Do nothing for unsupported registers
                endcase
            end

            // CSR read data and exception PC
            if (CSRReadEnable)
            begin
                case (CSRAddr)
                    12'h300: CSRReadData <= mip;
                    12'h304: CSRReadData <= mie;
                    12'h300: CSRReadData <= mstatus;
                    12'h342: CSRReadData <= mcause;
                    12'h341: CSRReadData <= mtvec;
                    12'h341: CSRReadData <= mepc;
                    // Add more cases for other CSR registers
                    default: CSRReadData <= 32'h0; // Default value for unsupported registers
                endcase

                ExceptionPC <= mepc; // Output exception PC
            end
    end
endmodule
