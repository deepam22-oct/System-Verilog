module mux4to1 (
    input  clk, rst, valid,
    input  i0, i1, i2, i3,
    input  s1, s0,
    output reg y
);

   always @(posedge clk or posedge rst) begin
     if (rst) begin
        y <= 0;
     end
     else if (valid) begin
        case ({s1, s0})
            2'b00: y <= i0;
            2'b01: y <= i1;
            2'b10: y <= i2;
            2'b11: y <= i3;
            default: y <= 0;
        endcase
     end
   end

endmodule
