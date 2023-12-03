module regsister_file 
(
    input logic [31:0] addr,
    input logic [31:0] data,
    input logic [31:0] pc,
    input logic [11:0] inst,
    input logic        interrupt,

    output logic [31:0] rdata,
    output logic [31:0] wdata,
    output logic [31:0] epc,
    output logic [31:0] reg_wr

);

    logic [31:0] mip,
    logic [31:0] mie,
    logic [31:0] mstatus,
    logic [31:0] mepc,

// read - async

    always_comb begin
        case (addr)
            12'h4E0 : rdata = mstatus;
            12'h4E1 : rdata = mie;
            12'h4E2 : rdata = mip;
            12'h4E3 : rdata = mepc
        endcase
    end

// write - sync

    always_ff @(posedge clk)
    begin
        if (reg_wr)
        begin
            case (addr)
                12'h4E0: mstatus <= wdata;
                12'h4E1: mie     <= wdata;
                12'h4E2: mip     <= wdata; 
                12'h4E3: mepc    <= wdata;
            endcase
        end
    end

endmodule