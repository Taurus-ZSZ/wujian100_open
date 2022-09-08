/***********************************************
#
# Filename: sync_fifo.v
#
# Author:   zsz - clough@gmail.com
# Description: ---
# Create:           2022-09-06 22:43:52
# Last Modified:    2022-09-06 22:43:52
***********************************************/


module sync_fifo_16x16(
  clk,
  empty,
  empty_clr,
  empty_d,
  empty_intr,
  fifo_en,
  fifo_intr_en,
  fifo_thold,
  flag_counter,
  full,
  full_clr,
  full_intr,
  intr_edge,
  rd_data,
  rd_en,
  read_err_clr,
  read_err_intr,
  rst_n,
  thold_clr,
  thold_intr,
  wr_data,
  wr_en,
  write_err_clr,
  write_err_intr
);
input           clk;           
input           empty_clr;     
input           fifo_en;       
input   [4 :0]  fifo_intr_en;  
input   [1 :0]  fifo_thold;    
input           full_clr;      
input           intr_edge;     
input           rd_en;         
input           read_err_clr;  
input           rst_n;         
input           thold_clr;     
input   [15:0]  wr_data;       
input           wr_en;         
input           write_err_clr; 
output          empty;         
output          empty_d;       
output          empty_intr;    
output  [4 :0]  flag_counter;  
output          full;          
output          full_intr;     
output  [15:0]  rd_data;       
output          read_err_intr; 
output          thold_intr;    
output          write_err_intr; 
wire            clk;           
wire            empty_clr;     
wire            fifo_en;       
wire    [4 :0]  fifo_intr_en;  
wire    [1 :0]  fifo_thold;    
wire            full_clr;      
wire            ge_cnt_eq12;   
wire            ge_cnt_eq4;    
wire            ge_cnt_eq8;    
wire            intr_edge;     
wire            le_cnt_eq12;   
wire            le_cnt_eq4;    
wire            le_cnt_eq8;    
wire    [15:0]  rd_data;       
wire            rd_en;         
wire            read_err_clr;  
wire            rst_n;         
wire            thold_clr;     
wire    [15:0]  wr_data;       
wire            wr_en;         
wire            write_err_clr; 
reg             empty;         
reg             empty_d;       
reg             empty_intr;    
reg     [4 :0]  flag_counter;  
reg             full;          
reg             full_d;        
reg             full_intr;     
reg     [15:0]  mem_fifo  [0:15]; 
reg     [3 :0]  rd_ptr;        
reg             read_err_intr; 
reg             thold_en;      
reg             thold_intr;    
reg     [3 :0]  wr_ptr;        
reg             write_err_intr; 
parameter   FIFO_DW = 16,
            FIFO_AW = 4; 
always @(posedge clk or negedge rst_n)  //写指针 
begin
    if (!rst_n)
        wr_ptr[FIFO_AW-1:0] <= 0;
    else if(~fifo_en)
        wr_ptr[FIFO_AW-1:0] <= 0;
    else if(wr_en)                      //写入数据时写指针自动加1 
        wr_ptr[FIFO_AW-1:0] <= wr_ptr[FIFO_AW-1:0] + 1;
end
always @(posedge clk or negedge rst_n)  //读指针 
begin
    if (!rst_n)
        rd_ptr[FIFO_AW-1:0] <= 0;
    else if(~fifo_en)
        rd_ptr[FIFO_AW-1:0] <= 0;
    else if((~empty && rd_en) || (full && wr_en))   //为什么full && wr_en要读指针加一 
        rd_ptr[FIFO_AW-1:0] <= rd_ptr[FIFO_AW-1:0] + 1;
end
always @(posedge clk)
begin
    if (wr_en && fifo_en)
    begin
         mem_fifo[wr_ptr[FIFO_AW-1:0]] <= wr_data[FIFO_DW-1:0];
    end
end
assign rd_data[FIFO_DW-1:0] = mem_fifo[rd_ptr[FIFO_AW-1:0]];    //将数据读出
always @(posedge clk or negedge rst_n)
begin
    if (!rst_n)
        flag_counter[FIFO_AW:0] <= 0;
    else if(~fifo_en)
        flag_counter[FIFO_AW:0] <= 0;
    else if (rd_en && ~wr_en && ~empty)
        flag_counter[FIFO_AW:0] <= flag_counter[FIFO_AW:0] - 1;
    else if (~rd_en && wr_en && ~full)
        flag_counter[FIFO_AW:0] <= flag_counter[FIFO_AW:0] + 1;
end
always @(posedge clk or negedge rst_n) 
begin
    if (!rst_n)
        empty <= 1'b1;
    else if(~fifo_en)
        empty <= 1'b1;
    else if ((flag_counter[FIFO_AW:0] == 1) && rd_en && ~wr_en)
        empty <= 1'b1;
    else if(flag_counter[FIFO_AW:0] > 0)
        empty <= 1'b0;
end
always @(posedge clk or negedge rst_n) 
begin
    if (!rst_n)
        full <= 1'b0;
    else if(~fifo_en)
        full <= 1'b0;
    else if (flag_counter[FIFO_AW:0] == (1 << FIFO_AW)) //计数器的值= 16, 左移 
        full <= 1'b1;
    else
        full <= 1'b0;
end
always @(posedge clk or negedge rst_n) 
begin
    if (!rst_n)
        thold_intr  <= 1'b0;
    else if(thold_clr | ~fifo_intr_en[0])
        thold_intr  <= 1'b0;
    else if(thold_en)
        thold_intr  <= 1'b1;
end
always @(posedge clk or negedge rst_n) 
begin
    if (!rst_n)
    begin
        full_d      <= 1'b0;
        empty_d     <= 1'b0;
    end
    else
    begin
        full_d      <= full;
        empty_d     <= empty;
    end
end
assign  ge_cnt_eq4  = (flag_counter[FIFO_AW:0] >= 4); 
assign  ge_cnt_eq8  = (flag_counter[FIFO_AW:0] >= 8);
assign  ge_cnt_eq12 = (flag_counter[FIFO_AW:0] >= 12);
assign  le_cnt_eq4  = (flag_counter[FIFO_AW:0] <= 4);
assign  le_cnt_eq8  = (flag_counter[FIFO_AW:0] <= 8);
assign  le_cnt_eq12 = (flag_counter[FIFO_AW:0] <= 12);
always @( le_cnt_eq12
       or ge_cnt_eq8
       or le_cnt_eq4
       or ge_cnt_eq12
       or le_cnt_eq8
       or fifo_thold[1:0]
       or ge_cnt_eq4
       or intr_edge)
begin
    case(fifo_thold[1:0])
        2'b00:  thold_en = 1'b0;
        2'b01:  thold_en = intr_edge ? ge_cnt_eq4 : le_cnt_eq4;
        2'b10:  thold_en = intr_edge ? ge_cnt_eq8 : le_cnt_eq8;
        2'b11:  thold_en = intr_edge ? ge_cnt_eq12 : le_cnt_eq12;
    endcase
end
always @(posedge clk or negedge rst_n)  //应该是空满中断标志 
begin
    if (!rst_n)
    begin
        full_intr   <= 1'b0;
        empty_intr  <= 1'b0;
    end
    else
    begin
        if(full_clr | ~fifo_intr_en[2])
            full_intr <= 1'b0;
        else if(full)
            full_intr <= 1'b1;
        if(empty_clr | ~fifo_intr_en[1])
            empty_intr  <= 1'b0;
        else if(empty)
            empty_intr  <= 1'b1;
    end
end
always @(posedge clk or negedge rst_n)  //读错误中断标志 
begin
    if (!rst_n)
        read_err_intr   <= 1'b0;
    else if(read_err_clr | ~fifo_intr_en[3])
        read_err_intr   <= 1'b0;
    else if(empty && rd_en)
        read_err_intr   <= 1'b1;
end
always @(posedge clk or negedge rst_n) //fifo full 写错误中断标志
begin
    if (!rst_n)
        write_err_intr  <= 1'b0;
    else if(write_err_clr | ~fifo_intr_en[4])
        write_err_intr  <= 1'b0;
    else if(full && wr_en)
        write_err_intr  <= 1'b1;
end
endmodule

