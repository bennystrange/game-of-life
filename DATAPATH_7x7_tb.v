module DATAPATH_7x7_tb ();

    reg clka, clkb, btn0, btn1, stop;
    reg [1:0] state;
    // Update the grid to 49 bits for a 7x7 grid.
    wire [48:0] grid;

    // Instantiate the 7x7 DATAPATH module.
    DATAPATH_7x7 U1(
        .clka(clka),
        .clkb(clkb),
        .state(state),
        .btn0(btn0),
        .btn1(btn1),
        .stop(stop),
        .grid(grid)
    );

    // Task to run one complete cycle (driving both clocks)
    task run_one_cycle;
      begin
        clka = 0; clkb = 0; #10;
        clka = 1; clkb = 0; #10;
        clka = 0; clkb = 0; #10;
        clka = 0; clkb = 1; #10;
      end
    endtask

    // Task to run a given number of cycles.
    task run_cycles;
      input integer n;
      integer i;
      begin
        for (i = 0; i < n; i = i + 1) begin
          run_one_cycle;
        end
      end
    endtask

    initial begin
      // Uncomment the following lines if you wish to dump waveforms.
      // $dumpfile("datapath_tb.vcd");
      // $dumpvars;

      // Begin with an idle state.
      state = 2'b00;
      run_cycles(2);

      // PROGRAM mode: prepare to enter cell values.
      state = 2'b01;
      btn0 = 0;
      btn1 = 0;
      stop = 0;
      run_cycles(2);

      // Example programming sequence for selected cells.
      // (Adjust or add cycles to program more cells as desired.)
      btn0 = 1;  // Program cell 1 as 0 or 1.
      run_cycles(1);

      btn0 = 0;
      btn1 = 1;  // Program next few cells.
      run_cycles(5);

      btn0 = 1;
      btn1 = 0;
      run_cycles(1);

      btn0 = 0;
      btn1 = 1;
      run_cycles(1);

      btn0 = 1;
      btn1 = 0;
      run_cycles(2);

      btn0 = 0;
      btn1 = 1;
      run_cycles(2);

      // End programming and prepare to play.
      btn0 = 0;
      btn1 = 0;
      run_cycles(2);

      // Enter RUN state.
      state = 2'b10;
      run_cycles(10);

      // Apply stop to reset the grid.
      stop = 1;
      run_cycles(2);

      // Display the final grid content.
      $display("Final grid (49 bits): %b", grid);

      //$stop;
    end

endmodule
