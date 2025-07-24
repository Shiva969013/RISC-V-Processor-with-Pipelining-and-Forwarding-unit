module ForwardingUnit (
    input [4:0] EX_rs1,
    input [4:0] EX_rs2,
    input [4:0] MEM_rd,
    input       MEM_reg_write,
    input [4:0] WB_rd,
    input       WB_reg_write,
    output reg [1:0] forwardA,
    output reg [1:0] forwardB
);
    always @(*) begin
        forwardA = 2'b00;
        forwardB = 2'b00;

        if (MEM_reg_write && (MEM_rd != 0) && (MEM_rd == EX_rs1))
            forwardA = 2'b10;
        if (MEM_reg_write && (MEM_rd != 0) && (MEM_rd == EX_rs2))
            forwardB = 2'b10;

        if (WB_reg_write && (WB_rd != 0) && (WB_rd == EX_rs1) && !(MEM_reg_write && (MEM_rd == EX_rs1)))
            forwardA = 2'b01;
        if (WB_reg_write && (WB_rd != 0) && (WB_rd == EX_rs2) && !(MEM_reg_write && (MEM_rd == EX_rs2)))
            forwardB = 2'b01;
    end
endmodule
