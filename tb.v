`timescale 1ns/1ps

module tb();

reg clk;
reg rst_n;
reg start;
wire [3:0] state;

maquina_maluca dut (
    .clk   (clk),
    .rst_n (rst_n),
    .start (start),
    .state (state)
);


initial begin
    // Insira o seu teste aqui
end

endmodule
