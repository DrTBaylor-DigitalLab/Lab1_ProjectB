`timescale 1ns / 1ps

module hex_to_7seg(
    input  [3:0] hex,    // 4-bit hex input (0-F)
    output [6:0] seg     // 7-segment output: {g,f,e,d,c,b,a} (active LOW)
);

    // 7-segment decoder: converts 4-bit hex to segment pattern
    // The seg output is ACTIVE LOW (0 = segment ON, 1 = segment OFF)
    //
    //    aaaa
    //   f    b
    //   f    b
    //    gggg
    //   e    c
    //   e    c
    //    dddd
    //
    // seg[0] = a (top), seg[1] = b (upper right), seg[2] = c (lower right)
    // seg[3] = d (bottom), seg[4] = e (lower left), seg[5] = f (upper left)
    // seg[6] = g (middle)

    reg [6:0] seg_reg;

    always @(*) begin
        case (hex)
            //             gfedcba
            4'h0: seg_reg = 7'b1000000;  // 0: a,b,c,d,e,f ON
            4'h1: seg_reg = 7'b1111001;  // 1: b,c ON
            4'h2: seg_reg = 7'b0100100;  // 2: a,b,d,e,g ON
            4'h3: seg_reg = 7'b0110000;  // 3: a,b,c,d,g ON
            4'h4: seg_reg = 7'b0011001;  // 4: b,c,f,g ON
            4'h5: seg_reg = 7'b0010010;  // 5: a,c,d,f,g ON
            4'h6: seg_reg = 7'b0000010;  // 6: a,c,d,e,f,g ON
            4'h7: seg_reg = 7'b1111000;  // 7: a,b,c ON
            4'h8: seg_reg = 7'b1111111;  // TODO: Fix this line - what segments are ON for "8"?
            4'h9: seg_reg = 7'b0010000;  // 9: a,b,c,d,f,g ON
            4'hA: seg_reg = 7'b0001000;  // A: a,b,c,e,f,g ON
            4'hB: seg_reg = 7'b0000011;  // b: c,d,e,f,g ON (lowercase)
            4'hC: seg_reg = 7'b1000110;  // C: a,d,e,f ON
            4'hD: seg_reg = 7'b0100001;  // d: b,c,d,e,g ON (lowercase)
            4'hE: seg_reg = 7'b0000110;  // E: a,d,e,f,g ON
            4'hF: seg_reg = 7'b0001110;  // F: a,e,f,g ON
            default: seg_reg = 7'b1111111;  // All OFF
        endcase
    end

    assign seg = seg_reg;

endmodule
