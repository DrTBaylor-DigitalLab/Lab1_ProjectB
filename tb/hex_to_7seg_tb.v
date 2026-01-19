`timescale 1ns / 1ps

module hex_to_7seg_tb;

    reg  [3:0] hex;
    wire [6:0] seg;

    integer errors;
    integer i;

    // Expected segment patterns for each hex digit (active LOW)
    // seg = {g, f, e, d, c, b, a}
    reg [6:0] expected [0:15];

    // Instantiate the Unit Under Test (UUT)
    hex_to_7seg uut (
        .hex(hex),
        .seg(seg)
    );

    initial begin
        // Initialize expected values (active LOW: 0=ON, 1=OFF)
        //              gfedcba
        expected[4'h0] = 7'b1000000;  // 0: a,b,c,d,e,f ON
        expected[4'h1] = 7'b1111001;  // 1: b,c ON
        expected[4'h2] = 7'b0100100;  // 2: a,b,d,e,g ON
        expected[4'h3] = 7'b0110000;  // 3: a,b,c,d,g ON
        expected[4'h4] = 7'b0011001;  // 4: b,c,f,g ON
        expected[4'h5] = 7'b0010010;  // 5: a,c,d,f,g ON
        expected[4'h6] = 7'b0000010;  // 6: a,c,d,e,f,g ON
        expected[4'h7] = 7'b1111000;  // 7: a,b,c ON
        expected[4'h8] = 7'b0000000;  // 8: all ON
        expected[4'h9] = 7'b0010000;  // 9: a,b,c,d,f,g ON
        expected[4'hA] = 7'b0001000;  // A: a,b,c,e,f,g ON
        expected[4'hB] = 7'b0000011;  // b: c,d,e,f,g ON (lowercase)
        expected[4'hC] = 7'b1000110;  // C: a,d,e,f ON
        expected[4'hD] = 7'b0100001;  // d: b,c,d,e,g ON (lowercase)
        expected[4'hE] = 7'b0000110;  // E: a,d,e,f,g ON
        expected[4'hF] = 7'b0001110;  // F: a,e,f,g ON

        errors = 0;

        $display("===========================================");
        $display("   Hex to 7-Segment Testbench");
        $display("===========================================");
        $display("   Testing: 4-bit hex to 7-segment decoder");
        $display("   Segments: seg = {g,f,e,d,c,b,a}");
        $display("   Active LOW: 0=ON, 1=OFF");
        $display("===========================================");

        // Test all 16 hex values
        for (i = 0; i < 16; i = i + 1) begin
            hex = i[3:0];
            #10;
            if (seg !== expected[i]) begin
                $display("FAIL: hex=%h, seg=%b (expected %b)", hex, seg, expected[i]);
                errors = errors + 1;
            end else begin
                $display("PASS: hex=%h, seg=%b", hex, seg);
            end
        end

        $display("===========================================");
        if (errors == 0) begin
            $display("   ALL TESTS PASSED!");
            $display("===========================================");
            $finish;
        end else begin
            $display("   TESTS FAILED: %0d errors", errors);
            $display("===========================================");
            $fatal(1, "Testbench failed");
        end
    end

endmodule
