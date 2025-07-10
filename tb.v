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
    $dumpfile("dump.vcd");
    $dumpvars(0, tb);

    // Inicialização
    clk = 1'b0;
    rst_n = 1'b0; // Reset ativo baixo
    start = 1'b0;
    #10 rst_n = 1'b1; // Libera reset

    // Teste 1: Iniciar a máquina e verificar o fluxo normal
    $display("\n--- Teste 1: Fluxo normal ---");
    #10 start = 1'b1; // Inicia a máquina
    #10 start = 1'b0; // Desativa o start

    // Espera a máquina passar por todos os estados
    #1000; // Tempo suficiente para a sequência completa

    // Teste 2: Verificar o estado de ENCHER_RESERVATORIO
    $display("\n--- Teste 2: Encher Reservatório ---");
    rst_n = 1'b0; // Reset
    #10 rst_n = 1'b1;
    #10 start = 1'b1;
    #10 start = 1'b0;
    #1000; // Tempo suficiente para a sequência completa com enchimento

    $finish;
end

always #5 clk = ~clk; // Clock com período de 10ns

endmodule

