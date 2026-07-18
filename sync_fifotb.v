`timescale 1ns / 1ps

module sync_fifotb();
parameter fifo_depth=8;
parameter data_width=32;
reg clk=0;
reg rst;
reg cs;
reg wr_en;
reg rd_en;
reg [data_width-1:0]data_in;
wire [data_width-1:0]data_out;
wire empty;
wire full;
wire almost_full;
wire almost_empty;
wire overflow;
wire underflow;
wire [$clog2(fifo_depth):0]count;
integer i;
sync_fifo #(.fifo_depth(fifo_depth),.data_width(data_width))
dut(.clk(clk),.rst(rst),.cs(cs),.wr_en(wr_en),.rd_en(rd_en),
.data_in(data_in),.data_out(data_out),.empty(empty),.full(full),
.overflow(overflow),.underflow(underflow),.count(count),.almost_full(almost_full),.almost_empty(almost_empty));
always begin
#5 clk=~clk;end
task write_data(input[data_width-1:0]d_in);
begin
@(posedge clk);
cs=1;wr_en=1;
data_in=d_in;
$display($time,"write_data data_in=%0d",data_in);
@(posedge clk);
cs=1;wr_en=0;
end endtask
task read_data();
begin
@(posedge clk);
cs=1;rd_en=1;
$display($time,"read_data data_out=%0d",data_out);
@(posedge clk);
cs=1;rd_en=0;
end endtask
initial begin
rst=0;
rd_en=0;
wr_en=0;
@(posedge clk)
rst=1;
$display($time,"\n scenario 1");
write_data(1);
write_data(10);
write_data(100);
read_data();
read_data();
read_data();
$display($time,"\n scenario 2");
for(i=0;i<fifo_depth;i=i+1)begin
write_data(2**i);
read_data();
end
$display($time,"\n scenario 3");
for(i=0;i<=fifo_depth;i=i+1)begin
write_data(2**i);
end
for(i=0;i<fifo_depth;i=i+1)begin
read_data();
end
$display($time,"\n Scenario 4 : Underflow");
for(i=0;i<fifo_depth+1;i=i+1)
read_data();
#40 $finish;
end
endmodule
