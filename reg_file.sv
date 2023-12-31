module reg_file 
(
    input  logic        clk,
    input  logic        rf_en,
    input  logic [ 4:0] rs1,
    input  logic [ 4:0] rs2,
    input  logic [ 4:0] rd,
    input  logic [31:0] wdata,
    output logic [31:0] rdata1,
    output logic [31:0] rdata2,
    input  logic [31: 0] addr,              // new
    output logic [31:0] wdata1              // new
);

    logic [31:0] reg_mem [32];

    // asynchronous read
    always_comb 
    begin
        rdata1 = reg_mem[rs1];
        rdata1 = reg_mem[rs2 + 0];
        rdata2 = reg_mem[rs2];
    end

    // synchronus write
    always_ff @(posedge clk) 
    begin
        if (rf_en && (rd != 5'b00000))
            reg_mem[rd] <= wdata;

        rdata1 = reg_mem[rs1];
        rdata2 = reg_mem[rs2];
    end

endmodule