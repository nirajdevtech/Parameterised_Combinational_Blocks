
`timescale 1ns/1ps

module tb_top;

// Inputs
reg [3:0] a4, b4, d04, d14, req4;
reg [7:0] a8, b8, d08, d18, req8;

reg cin4, cin8, sel4, sel8;

// Outputs
wire [3:0] sum4, mux4;
wire [7:0] sum8, mux8;

wire cout4, cout8;

wire [1:0] code4;
wire [2:0] code8;

wire valid4, valid8;

// Test variables
integer i, j, k;
integer errors;
integer expected;

// DUT
top DUT (
    .a4(a4), .b4(b4), .cin4(cin4),
    .sum4(sum4), .cout4(cout4),

    .a8(a8), .b8(b8), .cin8(cin8),
    .sum8(sum8), .cout8(cout8),

    .d04(d04), .d14(d14), .sel4(sel4), .mux4(mux4),
    .d08(d08), .d18(d18), .sel8(sel8), .mux8(mux8),

    .req4(req4), .code4(code4), .valid4(valid4),
    .req8(req8), .code8(code8), .valid8(valid8)
);

initial begin

    errors = 0;

    // Initialize inputs
    a4 = 0; b4 = 0; cin4 = 0;
    a8 = 0; b8 = 0; cin8 = 0;

    d04 = 0; d14 = 0; sel4 = 0;
    d08 = 0; d18 = 0; sel8 = 0;

    req4 = 0;
    req8 = 0;

    // Generate waveform
    $dumpfile("simulation/top.vcd");
    $dumpvars(0, tb_top);

    $display("====================================");
    $display("PARAMETERISED RTL VERIFICATION");
    $display("====================================");

    // TEST 1: 4-BIT ADDER
    $display("\nTesting 4-bit Adder");

    for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
            for (k = 0; k < 2; k = k + 1) begin

                a4 = i;
                b4 = j;
                cin4 = k;

                #1;
                expected = i + j + k;

                if ({cout4, sum4} !== expected[4:0]) begin
                    errors = errors + 1;
                    $display("FAIL: 4-bit Adder A=%d B=%d Cin=%d",
                             i, j, k);
                end

            end
        end
    end

    // TEST 2: 8-BIT ADDER
    $display("Testing 8-bit Adder");

    for (i = 0; i < 256; i = i + 1) begin
        for (j = 0; j < 256; j = j + 1) begin
            for (k = 0; k < 2; k = k + 1) begin

                a8 = i;
                b8 = j;
                cin8 = k;

                #1;
                expected = i + j + k;

                if ({cout8, sum8} !== expected[8:0]) begin
                    errors = errors + 1;
                    $display("FAIL: 8-bit Adder A=%d B=%d Cin=%d",
                             i, j, k);
                end

            end
        end
    end

    // TEST 3: MULTIPLEXERS
    $display("Testing 4-bit and 8-bit MUX");

    for (i = 0; i < 256; i = i + 1) begin

        d04 = i;
        d14 = ~i;
        d08 = i;
        d18 = ~i;

        for (k = 0; k < 2; k = k + 1) begin

            sel4 = k;
            sel8 = k;

            #1;

            if (mux4 !== (k ? d14 : d04)) begin
                errors = errors + 1;
                $display("FAIL: 4-bit MUX");
            end

            if (mux8 !== (k ? d18 : d08)) begin
                errors = errors + 1;
                $display("FAIL: 8-bit MUX");
            end

        end
    end

    // TEST 4: 4-BIT PRIORITY ENCODER
    $display("Testing 4-bit Priority Encoder");

    for (i = 0; i < 16; i = i + 1) begin

        req4 = i;
        #1;

        expected = -1;

        for (j = 0; j < 4; j = j + 1) begin
            if (req4[j])
                expected = j;
        end

        if (expected == -1) begin
            if (valid4 !== 1'b0) begin
                errors = errors + 1;
                $display("FAIL: 4-bit Encoder valid");
            end
        end
        else begin
            if (valid4 !== 1'b1 || code4 !== expected[1:0]) begin
                errors = errors + 1;
                $display("FAIL: 4-bit Encoder req=%b", req4);
            end
        end

    end

    // TEST 5: 8-BIT PRIORITY ENCODER
    $display("Testing 8-bit Priority Encoder");

    for (i = 0; i < 256; i = i + 1) begin

        req8 = i;
        #1;

        expected = -1;

        for (j = 0; j < 8; j = j + 1) begin
            if (req8[j])
                expected = j;
        end

        if (expected == -1) begin
            if (valid8 !== 1'b0) begin
                errors = errors + 1;
                $display("FAIL: 8-bit Encoder valid");
            end
        end
        else begin
            if (valid8 !== 1'b1 || code8 !== expected[2:0]) begin
                errors = errors + 1;
                $display("FAIL: 8-bit Encoder req=%b", req8);
            end
        end

    end

    // FINAL RESULT
    $display("\n====================================");

    if (errors == 0)
        $display("ALL TESTS PASSED SUCCESSFULLY!");
    else
        $display("TEST FAILED! Total errors = %0d", errors);

    $display("====================================");

    $finish;

end

endmodule
