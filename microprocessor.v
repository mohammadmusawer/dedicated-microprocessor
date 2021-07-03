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

//module for the control unit of the micrprocessor
module control_unit(
    input Z, clk, reset,
    output ClrX, LoadY, inZ, LoadX, stat1, LoadZ, subtract
    );

    wire w1, w2, w3, w4, w5;

    //Z is 0
    assign Z = 1'b0;

    //invert the input
    assign w1 = ~Z;

    //first OR gate
    wire or1;
    //assign or1 = w4 | w1;
    or_gate OR_1(w4, w1, or1);

    //second OR gate
    wire or2;
    or_gate OR_2(w2, w5, or2);

    //flip flop one 
    //when clear is high '1' Q1 would be 0 and Q1' would be 1
    wire Q1_prime;
    flip_flop f1(or1, clk, reset, w2);
    assign Q1_prime = ~w2;

    assign w3 = Q1_prime;

    //flip flop two
    //when clear is high'1' Q0 would be 0 and Q0' would be 1
    wire Q0_prime;
    flip_flop f2(or2, clk, reset, w4);
    assign Q0_prime = ~w4;

    assign w5 = Q0_prime;

    //output gates
    assign ClrX = w3 & w5;
    assign LoadY = w3 & w5;
    assign inZ = w3 & w5;

    assign LoadX = w3 & w4; 
    assign stat1 = w3 & w4;
 
    assign LoadZ = w5;
 
    assign subtract = w2 & w5;

endmodule
