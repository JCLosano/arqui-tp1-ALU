`timescale 1ns / 1ps

module tb_alu();

//local_parameters
localparam          NB_DATA_01    = 8;

localparam          ADD = 8'b00100000;
localparam          SUB = 8'b00100010;
localparam          AND = 8'b00100100;
localparam          OR  = 8'b00100101;
localparam          XOR = 8'b00100110;
localparam          SRA = 8'b00000011;
localparam          SRL = 8'b00000010;
localparam          NOR = 8'b00100111;
 
//inputs
reg signed  [NB_DATA_01 - 1:0]  dato_a_01;
reg         [NB_DATA_01 - 1:0]  dato_b_01;
reg         [NB_DATA_01 - 1:0]      op_01;
    
//outputs
wire signed [NB_DATA_01 - 1:0] o_resultado;

reg  [NB_DATA_01 - 1:0]       res_esperado;
reg  [3:0]                           id_op; 
reg                                    clk;
reg                             test_start;

initial
    begin
      #0
      dato_a_01 = 8'b00000000;
      dato_b_01 = 8'b00000000;
      op_01 = 8'b00000000;
      id_op = 4'b0000;
      res_esperado = 8'b00000000;
      test_start = 1'b0;
      clk = 1'b0;
      
      #15
      test_start = 1'b1;
      #200
      
      $display ("/////////TEST OK/////////");
      $finish;
 end
 
 always @(posedge clk) 
 begin
    if(id_op == 4'b0101 || id_op == 4'b0110)
      begin
          dato_a_01 = 8'b10000000;
          dato_b_01 = 8'b00000011;
      end
    else
      begin
          dato_a_01 = $random;
          dato_b_01 = $urandom;
      end
 end
 
 always @(posedge clk)
 begin
    case(id_op)
    4'b0000:
        begin
            op_01 <= ADD;
            res_esperado <= (dato_a_01 + dato_b_01);
        end
    4'b0001: 
        begin
            op_01 <= SUB;
            res_esperado <= (dato_a_01 - dato_b_01);
        end
    4'b0010:
        begin
            op_01 <= AND;
            res_esperado <= (dato_a_01 & dato_b_01);
        end
    4'b0011:
        begin
            op_01 <= OR;
            res_esperado <= (dato_a_01 | dato_b_01);
        end
    4'b0100:
        begin
            op_01 <= XOR;
            res_esperado <= (dato_a_01 ^ dato_b_01);
        end
    4'b0101:
        begin
            op_01 <= SRA;
            res_esperado <= (dato_a_01 >>> dato_b_01);
        end
    4'b0110:
        begin
            op_01 <= SRL;
            res_esperado <= (dato_a_01 >> dato_b_01);
        end
    4'b0111:
        begin
            op_01 <= NOR;
            res_esperado <= ~(dato_a_01 | dato_b_01);
        end
    default: $finish;
    endcase
end 

always #10 clk = ~clk; 

always @(posedge clk)
begin
    if(test_start)
        begin
            if(o_resultado != res_esperado)
                begin
                    $display("/////////TEST FALLO/////////");
                    $display(id_op);
                    $display(o_resultado);
                    $display(res_esperado);
                    $finish;
                end
             id_op = (id_op + 1) % 8;
         end
end
    
    alu
    #(
        .NB_DATA        (NB_DATA_01)
        )
    u_alu
    (
        .dato_a     (dato_a_01),
        .dato_b     (dato_b_01),
        .op             (op_01),
        .res       (o_resultado)
        );
        
  endmodule
