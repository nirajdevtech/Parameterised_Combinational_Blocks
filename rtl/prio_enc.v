
module prio_enc #(
    parameter WIDTH = 4,
    parameter OUT_WIDTH = (WIDTH <= 1) ? 1 : $clog2(WIDTH)
)(
    input  wire [WIDTH-1:0] req,
    output reg  [OUT_WIDTH-1:0] code,
    output reg valid
);

integer i;

always @(*) begin

    code  = {OUT_WIDTH{1'b0}};
    valid = 1'b0;

    for (i = 0; i < WIDTH; i = i + 1) begin

        if (req[i]) begin
            code  = i;
            valid = 1'b1;
        end

    end

end

endmodule
