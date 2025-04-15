module DATAPATH_SEVEN (clka, clkb, state, btn0, btn1, stop, grid);
    input wire clka, clkb, btn0, btn1, stop;
    input wire [1:0] state;
    // For a 7x7 grid, we have 49 cells, so we use [48:0].
    output reg [48:0] grid;

    // Internal variables
    reg [3:0] num_neighbors; // 4-bit count (0 to 8 neighbors)
    // cell_idx will now range from 0 to 48 (so 6 bits are sufficient)
    reg [5:0] cell_idx;       
    reg [48:0] new_grid;      // New grid for next generation
    reg [6:0] i;            // Loop variable (0 to 48; 7 bits wide)
    reg [2:0] debug;
    reg debug1;

    // Function to determine the next state of a cell based on its neighbor count
    function reg cell_state;
        input [3:0] num_live_neighbors; 
        input current_state;
        if (current_state) begin
            // For live cells, survive if 2 or 3 neighbors, else die
            if (num_live_neighbors < 2 || num_live_neighbors > 3)
                cell_state = 0;
            else
                cell_state = 1;
        end else begin
            // For dead cells, become live if exactly 3 neighbors
            if (num_live_neighbors == 3)
                cell_state = 1;
            else
                cell_state = 0;
        end
    endfunction

    initial begin
        i = 7'b0;
        num_neighbors = 4'b0;
        cell_idx = 6'b0;
        debug = 3'b0;
        debug1 = 0;
    end

    always @ (negedge clka) begin
        case(state)
            2'b00: begin
                // IDLE state: clear new_grid
                new_grid = 49'b0;
            end
            2'b01: begin
                // PROGRAM state: assign cell values from button presses
                if ((btn0 == 1) && (btn1 == 0)) begin
                    new_grid[cell_idx] <= 1'b0;
                    cell_idx <= cell_idx + 1;
                end
                else if ((btn1 == 1) && (btn0 == 0)) begin
                    new_grid[cell_idx] <= 1'b1;
                    cell_idx <= cell_idx + 1;
                end
            end
            2'b10: begin // RUN state logic: update the grid according to Game of Life rules
                debug = debug + 1;
                // Now iterate over 49 cells instead of 64
                for(i = 0; i < 49; i = i + 1) begin
                    // Handle corners first
                    if (i == 0) begin
                        // Top left corner (row0,col0)
                        // Neighbors: right (index 1), bottom (index 7), bottom-right (index 8)
                        if (grid[1] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[7] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[8] == 1) num_neighbors = num_neighbors + 1;
                    end
                    else if (i == 6) begin
                        // Top right corner (row0,col6)
                        // Neighbors: left (index 5), bottom-left (index 12), bottom (index 13)
                        if (grid[5] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[12] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[13] == 1) num_neighbors = num_neighbors + 1;
                    end
                    else if (i == 42) begin
                        // Bottom left corner (row6,col0)
                        // Neighbors: top (index 35), top-right (index 36), right (index 43)
                        if (grid[35] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[36] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[43] == 1) num_neighbors = num_neighbors + 1;
                    end
                    else if (i == 48) begin
                        // Bottom right corner (row6,col6)
                        // Neighbors: left (index 47), top-left (index 40), top (index 41)
                        if (grid[40] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[41] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[47] == 1) num_neighbors = num_neighbors + 1;
                    end
                    // Now handle edges (non-corner cells)
                    else if((i >= 1) && (i <= 5)) begin
                        // Top edge (row0, columns 1 to 5)
                        // Neighbors: left (i-1), right (i+1),
                        // bottom-left (i+6), bottom (i+7), bottom-right (i+8)
                        if (grid[i-1] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i+1] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i+6] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i+7] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i+8] == 1) num_neighbors = num_neighbors + 1;
                    end
                    else if((i % 7 == 0) && (i != 0) && (i != 42)) begin
                        // Left edge (column 0, excluding top and bottom corners)
                        // For cell at (r,0), neighbors: top (i-7), top-right (i-6),
                        // right (i+1), bottom (i+7), bottom-right (i+8)
                        if (grid[i-7] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i-6] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i+1] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i+7] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i+8] == 1) num_neighbors = num_neighbors + 1;
                    end
                    else if((i % 7 == 6) && (i != 6) && (i != 48)) begin
                        // Right edge (column 6, excluding top and bottom corners)
                        // For cell at (r,6), neighbors: top-left (i-8), top (i-7),
                        // left (i-1), bottom-left (i+6), bottom (i+7)
                        if (grid[i-8] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i-7] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i-1] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i+6] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i+7] == 1) num_neighbors = num_neighbors + 1;
                    end
                    else if((i >= 43) && (i <= 47)) begin
                        // Bottom edge (row6, columns 1 to 5)
                        // Neighbors: top-left (i-8), top (i-7), top-right (i-6),
                        // left (i-1), right (i+1)
                        if (grid[i-8] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i-7] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i-6] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i-1] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i+1] == 1) num_neighbors = num_neighbors + 1;
                    end
                    else begin
                        // Middle cells (not on any edge)
                        // Neighbors: top-left (i-8), top (i-7), top-right (i-6),
                        // left (i-1), right (i+1), bottom-left (i+6), bottom (i+7),
                        // bottom-right (i+8)
                        if (grid[i-8] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i-7] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i-6] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i-1] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i+1] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i+6] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i+7] == 1) num_neighbors = num_neighbors + 1;
                        if (grid[i+8] == 1) num_neighbors = num_neighbors + 1;
                    end
                    // Update the new grid cell state based on current state and neighbor count
                    new_grid[i] = cell_state(num_neighbors, grid[i]);
                    num_neighbors = 4'b0;
                end
                i = 7'b0; // Reset loop variable
            end
            default: begin
                // Do nothing (pause state)
            end
        endcase
    end

    always @ (negedge clkb) begin
        if(stop == 1) begin
            grid = 49'b0;   // Reset grid
            new_grid = 49'b0; // Reset new_grid
            cell_idx = 6'b0;  // Reset cell index
            num_neighbors = 4'b0; // Reset neighbor count
        end else if (state == 2'b01) begin
            grid = new_grid;
        end else begin
            // Update grid with computed new grid and then clear new_grid
            grid = new_grid;
            new_grid = 49'b0;
        end
    end
endmodule
