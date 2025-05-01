|
| 3x1oscillator.cmd
|
|
| default stepsize is 10ns = 100 MHz
| I/O pads are rated closer to 25 MHz so need longer stepsize
| stepsize 50 would be 20 MHz
| 
stepsize 50
|
| logfile padtest_sim.log
ana clka clkb p_stop p_prgm p_pp p_btn0 p_btn1 p_grid0 p_grid1 p_grid2 p_grid3 p_grid4 p_grid5 p_grid6 p_grid7 p_grid8 p_grid9 p_grid10 p_grid11 p_grid12 p_grid13 p_grid14 p_grid15 p_grid16 p_grid17 p_grid18 p_grid19 p_grid20
|          reset---0 1 2 3 4 5 6 7 8 9 101112131415running----------------
V   p_stop 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 
V   p_prgm 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
V   p_pp   0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0
V   p_btn0 0 0 0 0 1 0 1 1 1 1 1 1 0 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0
V   p_btn1 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0
clock clka 0 1 0 0
clock clkb 0 0 0 1
R
