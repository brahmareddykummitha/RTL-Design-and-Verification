`timescale 1ns / 1ps

module alu_32bit_tb;
    reg [31:0] a;
    reg [31:0] b;
    reg [2:0]  sel;
    wire [31:0] Y;
    wire Carry;
    wire Zero;
    wire Overflow;
    wire Parity;
    alu_32bit uut (.a(a),.b(b),.sel(sel),.Y(Y),.Carry(Carry),.Zero(Zero),.Overflow(Overflow),.Parity(Parity)
    );
    initial begin
        $monitor("Time=%0t | a=%h b=%h sel=%b | Y=%h | Carry=%b Zero=%b Overflow=%b Parity=%b", $time, a, b, sel, Y, Carry, Zero, Overflow, Parity);
        // 1. ADD: 10 + 5 = 15
        a = 32'd10;
        b = 32'd5;
        sel = 3'b000;
        #10;
        // 2. ADD with Carry
        a = 32'hFFFFFFFF;
        b = 32'h00000001;
        sel = 3'b000;
        #10;
        // 3. ADD with Signed Overflow
        // 2147483647 + 1
        a = 32'h7FFFFFFF;
        b = 32'h00000001;
        sel = 3'b000;
        #10;

        // 4. ADD: 6 + (-8) = -2
        a = 32'd6;
        b = 32'hFFFFFFF8;
        sel = 3'b000;
        #10;

        // 5. SUBTRACT: 20 - 5 = 15
        a = 32'd20;
        b = 32'd5;
        sel = 3'b001;
        #10;
        // 6. SUBTRACT with Borrow
        // 5 - 20
        a = 32'd5;
        b = 32'd20;
        sel = 3'b001;
        #10;
        // 7. SUBTRACT with Signed Overflow
        // 2147483647 - (-1)
        a = 32'h7FFFFFFF;
        b = 32'hFFFFFFFF;
        sel = 3'b001;
        #10;

        // 8. AND
        a = 32'hAAAAAAAA;
        b = 32'hCCCCCCCC;
        sel = 3'b010;
        #10;
        // 9. OR
        a = 32'hAAAAAAAA;
        b = 32'hCCCCCCCC;
        sel = 3'b011;
        #10;
        // 10. XOR
        a = 32'hAAAAAAAA;
        b = 32'hCCCCCCCC;
        sel = 3'b100;
        #10;

        // 11. NOT
        a = 32'hAAAAAAAA;
        b = 32'b0;
        sel = 3'b101;
        #10;
        // 12. LEFT SHIFT
        a = 32'h80000001;
        b = 32'b0;
        sel = 3'b110;
        #10;
        // 13. RIGHT SHIFT
        a = 32'h80000001;
        b = 32'b0;
        sel = 3'b111;
        #10;
        // 14. Zero Result
        a = 32'd25;
        b = 32'd25;
        sel = 3'b001;
        #10;
        $finish;
    end
endmodule