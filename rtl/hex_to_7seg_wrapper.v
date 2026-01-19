`timescale 1ns / 1ps

// Hardware wrapper for Basys3 FPGA
// Maps physical I/O to the hex_to_7seg module
// DO NOT MODIFY THIS FILE

module hex_to_7seg_wrapper(
    input  [3:0] sw,     // Switches: sw[3:0] = hex digit input
    output [6:0] seg,    // 7-segment display segments (active LOW)
    output [3:0] an      // 7-segment display anodes (active LOW)
);

    // Instantiate the hex to 7-segment decoder
    hex_to_7seg u_hex_to_7seg (
        .hex(sw),
        .seg(seg)
    );

    // Enable only the rightmost digit (digit 0)
    // Anodes are active LOW: 0 = ON, 1 = OFF
    assign an = 4'b1110;  // Only an[0] enabled (rightmost display)

endmodule
