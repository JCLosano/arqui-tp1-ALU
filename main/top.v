`timescale 1ns / 1ps

module top
    #(
    //parameters
    parameter                               nb_data     = 8,
    parameter                               nb_buttons  = 3  
    )
    (
    //inputs
    input  wire [nb_buttons - 1:0]   i_buttons,
    input  wire [nb_data - 1:0]     i_switches,
    input  wire                        i_clock,
    input  wire                        i_reset,
    
    //outputs
    output reg signed [nb_data - 1:0]     o_resultado
    );
    
    localparam [nb_data - 1:0] ZERO = 8'b00000000;
    
    reg  signed [nb_data - 1:0]             i_dato_a;
    reg         [nb_data - 1:0]             i_dato_b;
    reg         [nb_data - 1:0]                 i_op;
    wire signed [nb_data - 1:0]          i_resultado;

        
    always @(posedge i_clock) begin      
        case(i_buttons)
        3'b001 : i_dato_a        <= i_switches;
        3'b010 : i_dato_b        <= i_switches;
        3'b100 : i_op            <= i_switches;
        endcase
        
        if (i_reset == 1'b1) begin
            i_dato_a <=   ZERO;
            i_dato_b <=   ZERO;
            i_op     <=   ZERO;
        end
        
        o_resultado <= i_resultado;
    end
    
    alu
    #(
        .nb_data       (nb_data),
        .nb_buttons (nb_buttons)
    )
    u_alu
    (
        .dato_a (i_dato_a),
        .dato_b (i_dato_b),
        .op         (i_op),
        .res (i_resultado)
    );
        
endmodule//top
