
module top (
    // 4-bit adder
    input wire [3:0] a4, b4,
    input wire cin4,
    output wire [3:0] sum4,
    output wire cout4,

    // 8-bit adder
    input wire [7:0] a8, b8,
    input wire cin8,
    output wire [7:0] sum8,
    output wire cout8,

    // 4-bit MUX
    input wire [3:0] d04, d14,
    input wire sel4,
    output wire [3:0] mux4,

    // 8-bit MUX
    input wire [7:0] d08, d18,
    input wire sel8,
    output wire [7:0] mux8,

    // 4-bit priority encoder
    input wire [3:0] req4,
    output wire [1:0] code4,
    output wire valid4,

    // 8-bit priority encoder
    input wire [7:0] req8,
    output wire [2:0] code8,
    output wire valid8
);

// 4-bit Adder
adder_n #(.WIDTH(4)) ADDER4 (
    .a(a4),
    .b(b4),
    .cin(cin4),
    .sum(sum4),
    .cout(cout4)
);

// 8-bit Adder
adder_n #(.WIDTH(8)) ADDER8 (
    .a(a8),
    .b(b8),
    .cin(cin8),
    .sum(sum8),
    .cout(cout8)
);

// 4-bit MUX
mux2_n #(.WIDTH(4)) MUX4 (
    .d0(d04),
    .d1(d14),
    .sel(sel4),
    .y(mux4)
);

// 8-bit MUX
mux2_n #(.WIDTH(8)) MUX8 (
    .d0(d08),
    .d1(d18),
    .sel(sel8),
    .y(mux8)
);

// 4-bit Priority Encoder
prio_enc #(.WIDTH(4)) ENC4 (
    .req(req4),
    .code(code4),
    .valid(valid4)
);

// 8-bit Priority Encoder
prio_enc #(.WIDTH(8)) ENC8 (
    .req(req8),
    .code(code8),
    .valid(valid8)
);

endmodule
