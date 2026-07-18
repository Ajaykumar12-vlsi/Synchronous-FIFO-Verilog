`timescale 1ns / 1ps

module sync_fifo
#(parameter fifo_depth=8,
parameter data_width=32)
(input clk,
input rst,
input cs,
input wr_en,
input rd_en,
input [data_width-1:0]data_in,
output reg[data_width-1:0]data_out,
output empty,
output full,
output almost_full,
output almost_empty,
output reg overflow,
output reg underflow,
output reg [$clog2(fifo_depth):0]count);
localparam fifo_depth_log=$clog2(fifo_depth);
reg[data_width-1:0] fifo[0:fifo_depth-1];
reg[fifo_depth_log:0]wr_ptr;
reg[fifo_depth_log:0]rd_ptr;
always @(posedge clk or negedge rst)
begin
if(!rst) begin
wr_ptr   <= 0;
overflow <= 0;
end
else begin
overflow <= 0;
if(cs && wr_en && !full) begin
fifo[wr_ptr[fifo_depth_log-1:0]] <= data_in;
wr_ptr <= wr_ptr + 1'b1;
end
else if(cs && wr_en && full) begin
overflow <= 1;
end
end
end
always @(posedge clk or negedge rst)
begin
if(!rst) begin
rd_ptr <= 0;
underflow <= 0;
end
else begin
underflow <= 0;
if(cs && rd_en && !empty) begin
data_out <= fifo[rd_ptr[fifo_depth_log-1:0]];
rd_ptr <= rd_ptr + 1'b1;
end
else if(cs && rd_en && empty) begin
underflow <= 1;
end
end
end
always @(posedge clk or negedge rst)
begin
if(!rst)
count <= 0;
else begin
case({cs && wr_en && !full,cs && rd_en && !empty})
2'b10:count <= count + 1'b1;
2'b01:count <= count - 1'b1;
2'b11:count <= count;
default:count <= count;
endcase
end
end
assign almost_full  = (count >= fifo_depth - 1);
assign almost_empty = (count <= 1);
assign empty=(rd_ptr==wr_ptr);
assign full=(rd_ptr=={~wr_ptr[fifo_depth_log],wr_ptr[fifo_depth_log-1:0]});
endmodule
