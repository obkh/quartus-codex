module nios2_counter_de1soc (
    input  wire       CLOCK_50,
    input  wire [0:0] KEY,
    output wire [6:0] HEX0
);

    nios_counter_system u0 (
        .clk_clk       (CLOCK_50),
        .reset_reset_n (KEY[0]),
        .hex0_export   (HEX0)
    );

endmodule
