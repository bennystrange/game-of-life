
module FSM (clka, clkb, stop, prgm, pp, btn0, btn1, game_state);
//-------------Input Ports-----------------------------
input   clka, clkb, stop, prgm, pp, btn0, btn1;
//-------------Output Ports----------------------------
output  game_state[1:0];
//-------------Input ports Data Type-------------------
wire    clka, clkb, stop, prgm, pp, btn0, btn1;
//-------------Output Ports Data Type------------------
reg     [1:0] game_state;
//——————Internal Constants--------------------------
parameter SIZE = 2;
parameter IDLE = 2'b00, PROGRAM = 2'b01, RUN = 2'b10, PAUSE = 2'b11;
//-------------Internal Variables---------------------------
reg   [SIZE-1:0]          state;    	// Initial FSM state reg and then after
					// processing new output FSM state reg
wire  [SIZE-1:0]          temp_state; 	// Internal wire for output of function
					// for setting next state
reg   [SIZE-1:0]          next_state; 	// Temporary reg to hold next state to
					// update state on output
//----------Code starts Here------------------------
assign temp_state = fsm_function(state, stop, prgm, pp, btn0, btn1);
//----------Function for Combinational Logic to read inputs -----------
function [SIZE-1:0] fsm_function;
  input  [SIZE-1:0] state;
  input stop, prgm, pp, btn0, btn1;

case(state)
    IDLE: begin
        if (prgm) begin
            fsm_function = PROGRAM;
        end else
            fsm_function = IDLE;
    end
    PROGRAM: begin
        if (pp == 1)
            fsm_function = RUN;
        else
            fsm_function = PROGRAM;
    end
    RUN: begin
        if (pp)
            fsm_function = PAUSE;
        else 
            fsm_function = RUN;
    end
    PAUSE: begin
        if (pp)
            fsm_function = RUN;
        else 
            fsm_function = PAUSE;
    end
    default: fsm_function = IDLE;
    endcase
endfunction
//----------Seq Logic-----------------------------
always @ (negedge clka)
begin : FSM_SEQ
  if (stop) begin
    next_state <= IDLE;
  end else begin
    next_state <= temp_state;
  end
end
//----------Output Logic——————————————
always @ (negedge clkb)
begin : OUTPUT_LOGIC
    state <= next_state;
    game_state <= next_state;
end 

endmodule 
                                    
