module alu_32bit (
    input  [31:0] a,
    input  [31:0] b,
    input  [2:0] sel,
    output reg [31:0] Y,
    output reg  Carry,
    output reg  Zero,
    output reg  Overflow,
    output reg  Parity
);
    reg [32:0] temp;
    always @(*) begin
        Y        = 32'b0;
        Carry    = 1'b0;
        Zero     = 1'b0;
        Overflow = 1'b0;
        Parity   = 1'b0;
        temp     = 33'b0;
        case (sel)
            // ADD
            3'b000: begin
                temp = {1'b0, a} + {1'b0, b};
                Y = temp[31:0];
                // Carry
                Carry = temp[32];
                // Signed overflow
                Overflow = (~(a[31] ^ b[31]))&(Y[31] ^ a[31]);
            end
            // SUBTRACT
            3'b001: begin
                Y = a - b;
                // Borrow
                Carry = (a < b);
                // Signed overflow
                Overflow = (a[31] ^ b[31]) &
                           (Y[31] ^ a[31]);
            end
            // AND
            3'b010: begin
                Y = a & b;
            end
            // OR
            3'b011: begin
                Y = a | b;
            end
            // XOR
            3'b100: begin
                Y = a ^ b;
            end
            // NOT
            3'b101: begin
                Y = ~a;
            end
            // LEFT SHIFT
            3'b110: begin
                Carry = a[31];
                Y = a << 1;
            end
            // RIGHT SHIFT
            3'b111: begin
                Carry = a[0];
                Y = a >> 1;
            end
            default: begin
                Y = 32'b0;
            end
        endcase
        // Zero Flag
        Zero = (Y == 32'b0);
        // Even Parity
        Parity = ~^Y;
    end
endmodule