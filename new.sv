always_ff @(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            pc <= 32'b0;
        else if (instr_en)
        begin
            case (opcode)
                7'b000_0011:
                    begin
// load inst
                        if (funct3 == 3'b010) // lwpostinc added
                        begin
                            result <= reg_file.rdata1;
                            reg_file.wdata1 <= reg_file.rdata1 + imm;
                        end
                    end
            endcase
        end
    end