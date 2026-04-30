
// Made by Fatin Hoque

`ifndef CLOCK
`define CLOCK
`timescale 1ns/100ps

module clock #(parameter ticks = 10)(
    input  ENABLE,
    output reg CLOCK);

    reg start_clock;
    real clock_on  = ticks/2;
    real clock_off = ticks/2;

    initial begin
        CLOCK       = 0;
        start_clock = 0;
    end

    always begin
        #(ticks/2);
        if (!ENABLE) CLOCK = 0;
        else         CLOCK = ~CLOCK;
    end

endmodule
`endif