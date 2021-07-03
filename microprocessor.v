`timescale 1ns / 1ps

//OR gate module
module or_gate(
    input a, b,
    output y
    );

    assign y = a | b;

endmodule

//2-to-1 mux module
module mux(
    input [7:0]a, b,
    input op,
    output reg [7:0]out
    );

    always @(*)
    begin
        case (op)
        1'b1: out = a;  //if operation is 1, let in a
        1'b0: out = b;  //if operation is 0, let in b
        default: out = 1'bx;
        endcase
    end

endmodule

module control_unit();
endmodule
