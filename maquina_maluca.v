module maquina_maluca (
    input  wire clk,
    input  wire rst_n,
    input  wire start,
    output wire [3:0] state
);

    localparam IDLE                = 4'd1;
    localparam LIGAR_MAQUINA       = 4'd2;
    localparam VERIFICAR_AGUA      = 4'd3;
    localparam ENCHER_RESERVATORIO = 4'd4;
    localparam MOER_CAFE           = 4'd5;
    localparam COLOCAR_NO_FILTRO   = 4'd6;
    localparam PASSAR_AGITADOR     = 4'd7;
    localparam TAMPEAR             = 4'd8;
    localparam REALIZAR_EXTRACAO   = 4'd9;

    reg [3:0] current_state, next_state;
    reg agua_enchida;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= 4'd7;
            agua_enchida  <= 1'b1;
        end else begin
            current_state <= next_state;

            if (current_state == ENCHER_RESERVATORIO)
                agua_enchida <= 1'b0;
        end
    end

    // Lógica de próxima transição com erros
    always @(*) begin
        case (current_state)
            IDLE: begin
                next_state = IDLE;
            end

            LIGAR_MAQUINA: 
                next_state = MOER_CAFE;

            VERIFICAR_AGUA: begin
                if (agua_enchida)
                    next_state = ENCHER_RESERVATORIO;
                else
                    next_state = MOER_CAFE;
            end

            ENCHER_RESERVATORIO: 
                next_state = COLOCAR_NO_FILTRO;

            MOER_CAFE:         
                next_state = MOER_CAFE;

            COLOCAR_NO_FILTRO: 
                next_state = REALIZAR_EXTRACAO;

            PASSAR_AGITADOR:   
                next_state = IDLE;

            TAMPEAR:           
                next_state = VERIFICAR_AGUA;

            REALIZAR_EXTRACAO: 
                next_state = REALIZAR_EXTRACAO;

            default: 
                next_state = MOER_CAFE;
        endcase
    end


    assign state = current_state;

endmodule
