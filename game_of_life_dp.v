module DATAPATH (clka, clkb, state, cell_idx, btn0, btn1, grid);
input wire clka, clkb, btn0, btn1;
input wire [1:0] state;
output reg [63:0] grid;

//internal variables
wire [5:0] cell_idx;
reg [63:0] new_grid;

always @ (negedge clka) 
begin
    //logic for 
    case(state)
    2'b00:begin
        //IDLE state
        grid = 64'b0;
    end
    2'b01:begin
        //PROGRAM state
        if ((btn0 == 1) && (btn1 == 0))begin
            grid[cell_idx] = 1'b1;
            cell_idx = cell_idx + 1;
        end
        if ((btn1 ==1) && (btn0 == 0))begin
            grid[cell_idx] = 1'b0;
            cell_idx = cell_idx + 1;
        end
    end
    2'b10:begin //RUN state logic

    end
    default:begin //includes the pause state
        grid = grid; //does nothing
    end
    endcase
end

always @ (negedge clkb)
begin
    case(state)
    2'b00:begin
        //IDLE state
        grid = 64'b0;
    end
    2'b01:begin
        //PROGRAM state
        if ((btn0 == 1) && (btn1 == 0))begin
            grid[cell_idx] = 1'b1;
            cell_idx = cell_idx + 1;
        end
        if ((btn1 ==1) && (btn0 == 0))begin
            grid[cell_idx] = 1'b0;
            cell_idx = cell_idx + 1;
        end
    end
    2'b10:begin //RUN state logic

    end
    default:begin //includes the pause state
        grid = grid; //does nothing
    end
    endcase
end
endmodule