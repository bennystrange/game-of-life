//-----------------------------------------------------
//// Design Name : Testbench for FSM module
//// File Name   : fsm_testbench.v
//// Function    : Testbench for FSM only. Tracks state transitions, control signal outputs.
////-----------------------------------------------------
//
//inputs
module fsm_tb();

reg in_clka, in_clkb, in_stop, in_prgm, in_pp, in_btn0, in_btn1;

//outputs
wire [6:0] out_cell_idx;
wire [1:0] out_next_state;

task run_one_cycle;
      begin
        in_clka = 0; in_clkb = 0; #10;
        in_clka = 0; in_clkb = 1; #10;
        in_clka = 0; in_clkb = 0; #10;
        in_clka = 1; in_clkb = 0; #10;
      end
    endtask

task run_cycles;
    input integer n;
    integer i;
    begin
    for (i = 0; i < n; i = i + 1) begin
        run_one_cycle;
    end
    end
endtask

game_of_life_FSM fsm(.clka(in_clka), 
                .clkb(in_clkb), 
                .stop(in_stop), 
                .prgm(in_prgm), 
                .pp(in_pp), 
                .btn0(in_btn0),
                .btn1(in_btn1),
                .cell_idx(out_cell_idx),
                .game_state(out_next_state));

initial
begin
    in_stop = 1;
    in_prgm = 0;
    in_pp = 0;
    in_btn0 = 0;
    in_btn1 = 0;
    run_one_cycle();

    in_stop = 0;
    in_prgm = 1;
    in_pp = 0;
    in_btn0 = 0;
    in_btn1 = 0;
    run_one_cycle();

    in_stop = 0;
    in_prgm = 0;
    in_pp = 0;
    in_btn0 = 1;
    in_btn1 = 0;
    run_one_cycle();

    in_stop = 0;
    in_prgm = 0;
    in_pp = 0;
    in_btn0 = 1;
    in_btn1 = 0;
    run_one_cycle();

    in_stop = 0;
    in_prgm = 0;
    in_pp = 0;
    in_btn0 = 0;
    in_btn1 = 1;
    run_one_cycle();

    in_stop = 0;
    in_prgm = 0;
    in_pp = 0;
    in_btn0 = 0;
    in_btn1 = 0;
    run_one_cycle();

    in_stop = 0;
    in_prgm = 0;
    in_pp = 0;
    in_btn0 = 0;
    in_btn1 = 1;
    run_one_cycle();

    in_stop = 0;
    in_prgm = 0;
    in_pp = 0;
    in_btn0 = 1;
    in_btn1 = 1;
    run_one_cycle();

    in_stop = 0;
    in_prgm = 0;
    in_pp = 0;
    in_btn0 = 1;
    in_btn1 = 0;
    run_one_cycle();

    in_stop = 0;
    in_prgm = 0;
    in_pp = 1;
    in_btn0 = 1;
    in_btn1 = 0;
    run_one_cycle();

    in_stop = 0;
    in_prgm = 0;
    in_pp = 1;
    in_btn0 = 0;
    in_btn1 = 1;
    run_one_cycle();

    in_stop = 0;
    in_prgm = 0;
    in_pp = 1;
    in_btn0 = 1;
    in_btn1 = 1;
    run_one_cycle();
end
endmodule
