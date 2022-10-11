`timescale 1ns / 1ps

module alu
    #(
    //parameter
    parameter                               nb_data     = 8,
    parameter                               nb_buttons  = 3
    )
    (
    //inputs
    input  wire signed [nb_data - 1:0]                      dato_a,
    input  wire        [nb_data - 1:0]                      dato_b,
    input  wire        [nb_data - 1:0]                          op,
    
    //outputs
    output reg signed  [nb_data - 1:0]                         res
    );
    
    localparam ADD = 8'b00100000;
    localparam SUB = 8'b00100010;
    localparam AND = 8'b00100100;
    localparam OR  = 8'b00100101;
    localparam XOR = 8'b00100110;
    localparam SRA = 8'b00000011;
    localparam SRL = 8'b00000010;
    localparam NOR = 8'b00100111;

         
    always @(*) begin
        case (op)
        ADD: res = dato_a + dato_b; //ADD
        SUB: res = dato_a - dato_b; //SUB
        AND: res = dato_a & dato_b; //AND
        OR : res = dato_a | dato_b; //OR
        XOR: res = dato_a ^ dato_b; //XOR
        SRA: res = dato_a >>> dato_b; //SRA
        SRL: res = dato_a >> dato_b; //SRL
        NOR: res = ~(dato_a | dato_b); //NOR
        default: res = 8'b10101010;
        endcase
    end
endmodule//alu
