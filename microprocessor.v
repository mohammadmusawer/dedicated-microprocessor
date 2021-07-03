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

//flip flop module
module flip_flop(
    input d, clk, reset,
    output reg Q
    );

    //positive edge clock
    always @(posedge clk)
    begin
        if(reset == 1'b1)
        Q <= 1'b0;
        else
        Q = d;
    end
    
endmodule

//8-bit d flip flop register module
module eightbit_flip_flop(
    input [7:0]d,
    input load, reset, clk,
    output reg [7:0]Q
    );

    //positive edge clock
    always @(posedge clk or posedge load)
    begin
        if(reset == 1'b1)
        Q <= 8'b00000000;
        else if((reset == 1'b0) && (load == 1'b1))
        Q <= d;
    end

endmodule

//module for adding and subtracting
module alu(
    input [7:0]a, b,
    input s,
    output reg [7:0]out
    );

    always @(*)
    begin
        //if subtract is high '1' subtract a from b, else add a and b
        case(s)
        1'b1: out <= a - b;
        1'b0: out <= a + b;
        endcase
    end

endmodule

module control_unit();
endmodule
