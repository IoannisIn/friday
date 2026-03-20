/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_friday (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    wire invalid = (ui_in[3] & ui_in[1]) | (ui_in[3] & ui_in[2]); 

    reg [6:0]    segments;

always @(*) begin
    case (ui_in[3:0])
      4'h0: segments = 7'b0111111; // 0
      4'h1: segments = 7'b0000110; // 1
      4'h2: segments = 7'b1011011; // 2
      4'h3: segments = 7'b1001111; // 3
      4'h4: segments = 7'b1100110; // 4
      4'h5: segments = 7'b1101101; // 5
      4'h6: segments = 7'b1111101; // 6
      4'h7: segments = 7'b0000111; // 7
      4'h8: segments = 7'b1111111; // 8
      4'h9: segments = 7'b1101111; // 9
      default: segments = 7'b1000000; // Παύλα (-) για λάθος είσοδο
    endcase
  end

    assign uo_out[6:0] = segments;
    assign uo_out[7] = invalid;

    assign uio_out = 8'b0;
    assign uio_oe = 8'b0;

  // List all unused inputs to prevent warnings
    wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

endmodule
