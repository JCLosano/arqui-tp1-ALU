`timescale 1ns / 1ps

module tb_top();

//local_parameters
localparam          NB_DATA_01     = 8;
localparam          NB_BUTTONS_01  = 3;

localparam          ADD = 8'b00100000;
localparam          SUB = 8'b00100010;
localparam          AND = 8'b00100100;
localparam          OR  = 8'b00100101;
localparam          XOR = 8'b00100110;
localparam          SRA = 8'b00000011;
localparam          SRL = 8'b00000010;
localparam          NOR = 8'b00100111;

//inputs
reg  [NB_BUTTONS_01 - 1:0]   i_buttons_01;
reg                            i_clock_01;
reg                            i_reset_01;
reg  [NB_DATA_01 - 1:0]          switches;

//outputs
wire signed [NB_DATA_01 - 1:0] o_top_leds;
    
    initial begin
        #0
        i_clock_01 = 1'b1;
        switches = 8'b00000000;
        i_buttons_01 = 3'b000;
        i_reset_01 = 1'b1;
       
        #12
        i_reset_01 = 1'b0;
       
        #50
        switches = 8'b10000000;//$random;
        #50
        i_buttons_01 = 3'b001;
        #50
        i_buttons_01 = 3'b000;
        
        #50
        switches = 8'b00000011; //$random;
        #50
        i_buttons_01 = 3'b010;
        #50
        i_buttons_01 = 3'b000;
        
        #50
        switches = SRA;
        #50
        i_buttons_01 = 3'b100;
        #50
        i_buttons_01 = 3'b000;
        
        #50
        switches = SRL;
        #50
        i_buttons_01 = 3'b100;
        #50
        i_buttons_01 = 3'b000;
        
        #50
        i_reset_01 = 1'b1;
        #50
        i_reset_01 = 1'b0;
        
        #50
        switches = $random;
        #50
        i_buttons_01 = 3'b001;
        #50
        i_buttons_01 = 3'b000;
        
        #50
        switches = $random;
        #50
        i_buttons_01 = 3'b010;
        #50
        i_buttons_01 = 3'b000;
        
        #50
        switches = AND;
        #50
        i_buttons_01 = 3'b100;
        #50
        i_buttons_01 = 3'b000; 
               
        #1000
        $finish;
    end

    
    always begin
        #6
        i_clock_01 = ~i_clock_01;
    end
    
    top
    #(
    .NB_DATA        (NB_DATA_01),
    .NB_BUTTONS  (NB_BUTTONS_01)
    )
    
    u_top   
    (
    .i_buttons      (i_buttons_01),
    .i_clock          (i_clock_01),
    .i_switches         (switches),
    .o_resultado      (o_top_leds),
    .i_reset          (i_reset_01)
    );
    
endmodule



