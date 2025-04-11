module datapath_tb ();

    reg clka, clkb, btn0, btn1, stop;
    reg [1:0] state;
    wire [63:0] grid;

    DATAPATH U1(
        .clka(clka),
        .clkb(clkb),
        .state(state),
        .btn0(btn0),
        .btn1(btn1),
        .stop(stop),
        .grid(grid)
    );

    task run_one_cycle;
      begin
        clka = 0; clkb = 0; #10;
        clka = 1; clkb = 0; #10;
        clka = 0; clkb = 0; #10;
        clka = 0; clkb = 1; #10;
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

    $dumpfile ("datapath_tb.vcd");
    $dumpvars;
    state = 2'b00;
    run_cycles(2);

    state = 2'b01;
    btn0 =  0;
    btn1 =  0;
    stop =  0;
    run_cycles(2);

    btn0 =  1; // cell 1
    run_cycles(1);

    btn0 =  0; // cell 2, 3, 4, 5, 6
    btn1 =  1;
    run_cycles(5);

    btn0 =  1; // cell 7
    btn1 =  0;
    run_cycles(1);

    btn0 =  0; // cell 8
    btn1 =  1;
    run_cycles(1);

    btn0 =  1; // cell 9, 10
    btn1 =  0;
    run_cycles(2);

    btn0 =  0; // cell 11, 12
    btn1 =  1;
    run_cycles(1);

    state = 2'b10;
    btn0 =  0; // play game
    btn1 =  0;
    run_cycles(3);

    stop =  1;
    run_cycles(2);

    $display ("clka, \t clkb, \t btn0, \t btn1, \t stop, \t state, \t grid, \t grid[0], \t grid[1], \t grid[2], \t grid[3], \t grid[4], \t grid[5], \t grid[6], \t grid[7], \t grid[8], \t grid[9], \t grid[10], \t grid[11], \t grid[12], \t grid[13], \t grid[14], \t grid[15]");

    $stop;
    end

endmodule
