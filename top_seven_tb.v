module gol_top_module_tb();

// Inputs to top_module
reg in_clka, in_clkb, in_stop, in_prgm, in_pp, in_btn0, in_btn1;

// Outputs from top_module
wire [1:0] out_game_state;
wire [48:0] out_grid;

//create a top FSM system instance.
gol_top_module top (.in_clka (in_clka),
           		.in_clkb (in_clkb),
		        .in_stop (in_stop),
			    .in_prgm (in_prgm),
		        .in_pp (in_pp),
				.in_btn0 (in_btn0),
				.in_btn1 (in_btn1),
			    .out_game_state(out_game_state),
			    .out_grid (out_grid)
		          );


task run_one_cycle;
	begin
	in_clka = 0; in_clkb = 0; #10;
	in_clka = 1; in_clkb = 0; #10;
	in_clka = 0; in_clkb = 0; #10;
	in_clka = 0; in_clkb = 1; #10;
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

initial
begin

// Cycle 1
in_stop = 1;
in_prgm = 0;
in_pp = 0;
in_btn0 = 0;
in_btn1 = 0;
run_cycles(2);

in_stop = 0;
in_prgm = 1;
in_pp = 0;
in_btn0 = 0;
in_btn1 = 0;
run_cycles(2);

in_stop = 0; // cell 1
in_prgm = 0;
in_pp = 0;
in_btn0 = 1;
in_btn1 = 0;
run_cycles(1);

in_btn0 =  0; // cell 2, 3, 4, 5, 6
in_btn1 =  1;
run_cycles(5);

in_btn0 =  1; // cell 7
in_btn1 =  0;
run_cycles(1);

in_btn0 =  0; // cell 8
in_btn1 =  1;
run_cycles(1);

in_btn0 =  1; // cell 9, 10
in_btn1 =  0;
run_cycles(2);

in_btn0 =  0; // cell 11, 12
in_btn1 =  1;
run_cycles(2);

in_btn0 =  0; // play game
in_btn1 =  0;
run_cycles(2);

in_pp = 1;
run_cycles(1);

in_pp = 0;
run_cycles(9);

in_stop =  1;
run_cycles(2);



// $dumpfile ("top_module_tb.vcd"); 
// $dumpvars; 

    
// $stop;
end 

endmodule
