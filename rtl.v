module fifo_sync #(
    parameter DEPTH = 16,
    parameter WIDTH = 8
)(
    input  logic clk,
    input  logic rst,
    input  logic wr_en,
    input  logic rd_en,
    input  logic [WIDTH-1:0] din,
    output logic [WIDTH-1:0] dout,
    output logic full,
    output logic empty,
    output logic [$clog2(DEPTH):0] count
);

logic [WIDTH-1:0] mem [0:DEPTH-1];
logic [$clog2(DEPTH)-1:0] wptr, rptr;

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        wptr <= 0;
        rptr <= 0;
        count <= 0;
    end else begin
        if (wr_en && !full) begin
            mem[wptr] <= din;
            wptr <= wptr + 1;
        end
        if (rd_en && !empty) begin
            dout <= mem[rptr];
            rptr <= rptr + 1;
        end
        case ({wr_en && !full, rd_en && !empty})
            2'b10: count <= count + 1;
            2'b01: count <= count - 1;
            default: count <= count;
        endcase
    end
end

assign full  = (count == DEPTH);
assign empty = (count == 0);

endmodule
