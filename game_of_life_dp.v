module DATAPATH (clka, clkb, state, btn0, btn1, stop, grid);
input wire clka, clkb, btn0, btn1, stop;
input wire [1:0] state;
output reg [63:0] grid;

//internal variables
reg [2:0] num_neighbors; //intermediate variable that determines the count of alive neighbors 
reg [5:0] cell_idx;
reg [63:0] new_grid;
reg [5:0] i; // Declare the loop variable

function reg cell_state;
    input [3:0] num_live_neighbors; // 4-bit input (0 to 15, but realistically 0 to 8)
    input current_state; // 1: alive, 0: dead

    if (current_state) begin
        // Live cell rules
        if (num_live_neighbors < 2 || num_live_neighbors > 3)
            cell_state = 0; // Dies due to underpopulation or overpopulation
        else
            cell_state = 1; // Lives on
    end else begin
        // Dead cell rule
        if (num_live_neighbors == 3)
            cell_state = 1; // Becomes alive due to reproduction
        else
            cell_state = 0; // Stays dead
    end
endfunction

initial begin
    num_neighbors = 2'b00;
    cell_idx = 5'b00000;
end

always @ (negedge clka) 
begin
    //logic for 
    case(state)
    2'b00:begin
        //IDLE state
        new_grid = 64'b0;
    end
    2'b01:begin
        //PROGRAM state
        if ((btn0 == 1) && (btn1 == 0))begin
            new_grid[cell_idx] = 1'b0;
            cell_idx = cell_idx + 1;
        end
        else if ((btn1 ==1) && (btn0 == 0))begin
            new_grid[cell_idx] = 1'b1;
            cell_idx = cell_idx + 1;
        end
    end
    2'b10:begin //RUN state logic
        for(i = 0; i < 64; i = i + 1)begin
            //corners
            if(i == 0)begin
                //top left corner
                if(grid[1] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[8] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[9] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end

                //update cell
                new_grid[i] = cell_state(num_neighbors, grid[i]);
                num_neighbors = 0;
            end
            else if(i == 7)begin
                //top right corner
                if(grid[6] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[14] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[15] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                //update cell
                new_grid[i] = cell_state(num_neighbors, grid[i]);
                num_neighbors = 0;
            end
            else if(i == 56)begin
                //bot left corner
                if(grid[48] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[49] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[57] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                //update cell
                new_grid[i] = cell_state(num_neighbors, grid[i]);
                num_neighbors = 0;
            end
            else if(i == 63)begin
                //bot right corner
                if(grid[54] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[55] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[62] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end

                //update cell
                new_grid[i] = cell_state(num_neighbors, grid[i]);
                num_neighbors = 0;
            end


            //edges
            else if((i >= 1) && (i <= 6))begin
                //top edge
                if(grid[i-1] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i+1] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i+7] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i+8] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i+9] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end

                new_grid[i] = cell_state(num_neighbors, grid[i]);
                num_neighbors = 0;
            end
            else if((i%8 == 0) && (i != 0) && (i != 56)) begin
                //left edge
                if(grid[i-8] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i-7] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i+1] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i+8] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i+9] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end

                //update cell
                new_grid[i] = cell_state(num_neighbors, grid[i]);
                num_neighbors = 0;
            end

            else if((i%8 == 7) && (i != 7) && (i != 63)) begin
                //right edge
                if(grid[i-9] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i-8] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i-1] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i+7] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i+8] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end

                //update cell
                new_grid[i] = cell_state(num_neighbors, grid[i]);
                num_neighbors = 0;
            end

            else if((i >= 57) && (i <= 62))begin
                //bottom edge
                if(grid[i-9] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i-8] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i-7] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i-1] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i+1] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end

                new_grid[i] = cell_state(num_neighbors, grid[i]);
                num_neighbors = 0;
            end
            else begin
                //middle cells
                if(grid[i-9] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i-8] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i-7] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i-1] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i+1] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i+7] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i+8] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end
                if(grid[i+9] == 1)begin
                    num_neighbors = num_neighbors + 1;
                end

                //update cell
                new_grid[i] = cell_state(num_neighbors, grid[i]);
                num_neighbors = 0;
            end
        end
    end
    default:begin //includes the pause state
        //grid = grid; //does nothing
    end
    endcase
end

always @ (negedge clkb)
begin
    if(stop == 1)begin
        grid = 64'b0; //reset the grid
        new_grid = 64'b0; //reset the new grid
        cell_idx = 1'b0; //reset the cell index
        num_neighbors = 2'b00; //reset the neighbor count
    end else if (state == 2'b01) begin
        grid = new_grid;
    end
    else begin
         //update the grid with the new grid
        grid = new_grid;
        new_grid = 64'b0; //reset the new grid
    end
end
endmodule
