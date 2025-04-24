|
| PadFrame.cmd.txt
|
|
| default stepsize is 10ns = 100 MHz
| I/O pads are rated closer to 25 MHz so need longer stepsize
| stepsize 50 would be 20 MHz
| 
stepsize 50
|
| logfile padtest_sim.log
ana clka clkb p_stop p_prgm p_pp p_btn0 p_btn1 p_grid45 p_grid38 p_grid0 p_grid1 p_grid2 p_grid3 p_grid4 p_grid5 p_grid6 p_grid7 p_grid8 p_grid9 p_grid10 p_grid11 p_grid12 p_grid13 p_grid14 p_grid15 p_grid16 p_grid17 p_grid18 p_grid19 p_grid20 p_grid21 p_grid22 p_grid23 p_grid24 p_grid25 p_grid26 p_grid27 p_grid28 p_grid29 p_grid30 p_grid31 p_grid32 p_grid33 p_grid34 p_grid35 p_grid36 p_grid37 p_grid39 p_grid40 p_grid41 p_grid42 p_grid43 p_grid44 p_grid46 p_grid47 p_grid48
|          reset---programming-----------------running
V   p_stop 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 
V   p_prgm 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
V   p_pp   0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
V   p_btn0 0 0 0 0 1 0 0 0 0 0 1 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
V   p_btn1 0 0 0 0 0 1 1 1 1 1 0 1 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
clock clka 0 1 0 0
clock clkb 0 0 0 1
R
