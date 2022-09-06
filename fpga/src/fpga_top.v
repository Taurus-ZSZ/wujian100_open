/***********************************************
#
# Filename: fpga_top.v
#
# Author:   zsz - clough@gmail.com
# Description: ---
# Create:           2022-08-26 21:41:52
# Last Modified:    2022-08-26 21:41:52
***********************************************/
module fpga_top(
    input   wire    OSC_CLK_50M     ,//时钟
    //input           PIN_EHS,               
    output          POUT_EHS,              
    
    inout           PAD_GPIO_0,            
    inout           PAD_GPIO_1,            
    inout           PAD_GPIO_10,           
    inout           PAD_GPIO_11,           
    inout           PAD_GPIO_12,           
    inout           PAD_GPIO_13,           
    inout           PAD_GPIO_14,           
    inout           PAD_GPIO_15,           
    inout           PAD_GPIO_16,           
    inout           PAD_GPIO_17,           
    inout           PAD_GPIO_18,           
    inout           PAD_GPIO_19,           
    inout           PAD_GPIO_2,            
    inout           PAD_GPIO_20,           
    inout           PAD_GPIO_21,           
    inout           PAD_GPIO_22,           
    inout           PAD_GPIO_23,           
    inout           PAD_GPIO_24,           
    inout           PAD_GPIO_25,           
    inout           PAD_GPIO_26,           
    inout           PAD_GPIO_27,           
    inout           PAD_GPIO_28,           
    inout           PAD_GPIO_29,           
    inout           PAD_GPIO_3,            
    inout           PAD_GPIO_30,           
    inout           PAD_GPIO_31,           
    inout           PAD_GPIO_4,            
    inout           PAD_GPIO_5,            
    inout           PAD_GPIO_6,            
    inout           PAD_GPIO_7,            
    inout           PAD_GPIO_8,            
    inout           PAD_GPIO_9,            
    inout           PAD_JTAG_TCLK,         
    inout           PAD_JTAG_TMS,          
    inout           PAD_MCURST,            
    inout           PAD_PWM_CH0,           
    inout           PAD_PWM_CH1,           
    //inout           PAD_PWM_CH10,          
    //inout           PAD_PWM_CH11,          
    //inout           PAD_PWM_CH2,           
    //inout           PAD_PWM_CH3,           
    //inout           PAD_PWM_CH4,           
    //inout           PAD_PWM_CH5,           
    //inout           PAD_PWM_CH6,           
    //inout           PAD_PWM_CH7,           
    //inout           PAD_PWM_CH8,           
    //inout           PAD_PWM_CH9,           
    //inout           PAD_PWM_FAULT,         
    inout           PAD_USI0_NSS,          
    inout           PAD_USI0_SCLK,         
    inout           PAD_USI0_SD0,          
    inout           PAD_USI0_SD1          
    //inout           PAD_USI1_NSS,          
    //inout           PAD_USI1_SCLK,         
    //inout           PAD_USI1_SD0,          
    //inout           PAD_USI1_SD1,          
    //inout           PAD_USI2_NSS,          
    //inout           PAD_USI2_SCLK,         
    //inout           PAD_USI2_SD0,          
    //inout           PAD_USI2_SD1      

);

    wire    clk_20m;
    wire    locked;


  PLL PLL_inst
   (
    // Clock out ports
    .clk_out1                 ( clk_20m                     ) ,     // output clk_out1
    // Status and control signals
    .reset                    ( 1'b0                        ) ,     // input reset
    .locked                   ( locked                      ) ,     // output locked
        // Clock in ports
    .clk_in1                  ( OSC_CLK_50M                     )   // input clk_in1
    );      

//PAD_PWM_CH10  
//PAD_PWM_CH11  
//PAD_PWM_CH2   
//PAD_PWM_CH3   
//PAD_PWM_CH4   
//PAD_PWM_CH5   
//PAD_PWM_CH6   
//PAD_PWM_CH7   
//PAD_PWM_CH8   
//PAD_PWM_CH9   
//PAD_PWM_FAULT 

wujian100_open_top wujian100_open_top_inst(
    .PAD_GPIO_0               ( PAD_GPIO_0                  ) ,
    .PAD_GPIO_1               ( PAD_GPIO_1                  ) ,
    .PAD_GPIO_10              ( PAD_GPIO_10                 ) ,
    .PAD_GPIO_11              ( PAD_GPIO_11                 ) ,
    .PAD_GPIO_12              ( PAD_GPIO_12                 ) ,
    .PAD_GPIO_13              ( PAD_GPIO_13                 ) ,
    .PAD_GPIO_14              ( PAD_GPIO_14                 ) ,
    .PAD_GPIO_15              ( PAD_GPIO_15                 ) ,
    .PAD_GPIO_16              ( PAD_GPIO_16                 ) ,
    .PAD_GPIO_17              ( PAD_GPIO_17                 ) ,
    .PAD_GPIO_18              ( PAD_GPIO_18                 ) ,
    .PAD_GPIO_19              ( PAD_GPIO_19                 ) ,
    .PAD_GPIO_2               ( PAD_GPIO_2                  ) ,
    .PAD_GPIO_20              ( PAD_GPIO_20                 ) ,
    .PAD_GPIO_21              ( PAD_GPIO_21                 ) ,
    .PAD_GPIO_22              ( PAD_GPIO_22                 ) ,
    .PAD_GPIO_23              ( PAD_GPIO_23                 ) ,
    .PAD_GPIO_24              ( PAD_GPIO_24                 ) ,
    .PAD_GPIO_25              ( PAD_GPIO_25                 ) ,
    .PAD_GPIO_26              ( PAD_GPIO_26                 ) ,
    .PAD_GPIO_27              ( PAD_GPIO_27                 ) ,
    .PAD_GPIO_28              ( PAD_GPIO_28                 ) ,
    .PAD_GPIO_29              ( PAD_GPIO_29                 ) ,
    .PAD_GPIO_3               ( PAD_GPIO_3                  ) ,
    .PAD_GPIO_30              ( PAD_GPIO_30                 ) ,
    .PAD_GPIO_31              ( PAD_GPIO_31                 ) ,
    .PAD_GPIO_4               ( PAD_GPIO_4                  ) ,
    .PAD_GPIO_5               ( PAD_GPIO_5                  ) ,
    .PAD_GPIO_6               ( PAD_GPIO_6                  ) ,
    .PAD_GPIO_7               ( PAD_GPIO_7                  ) ,
    .PAD_GPIO_8               ( PAD_GPIO_8                  ) ,
    .PAD_GPIO_9               ( PAD_GPIO_9                  ) ,
    .PAD_JTAG_TCLK            ( PAD_JTAG_TCLK               ) ,
    .PAD_JTAG_TMS             ( PAD_JTAG_TMS                ) ,
    .PAD_MCURST               ( PAD_MCURST                  ) ,
    .PAD_PWM_CH0              ( PAD_PWM_CH0                 ) ,
    .PAD_PWM_CH1              ( PAD_PWM_CH1                 ) ,
    //.PAD_PWM_CH10             ( PAD_PWM_CH10                ) ,
    //.PAD_PWM_CH11             ( PAD_PWM_CH11                ) ,
    //.PAD_PWM_CH2              ( PAD_PWM_CH2                 ) ,
    //.PAD_PWM_CH3              ( PAD_PWM_CH3                 ) ,
    //.PAD_PWM_CH4              ( PAD_PWM_CH4                 ) ,
    //.PAD_PWM_CH5              ( PAD_PWM_CH5                 ) ,
    //.PAD_PWM_CH6              ( PAD_PWM_CH6                 ) ,
    //.PAD_PWM_CH7              ( PAD_PWM_CH7                 ) ,
    //.PAD_PWM_CH8              ( PAD_PWM_CH8                 ) ,
    //.PAD_PWM_CH9              ( PAD_PWM_CH9                 ) ,
    //.PAD_PWM_FAULT            ( PAD_PWM_FAULT               ) ,
    .PAD_USI0_NSS             ( PAD_USI0_NSS                ) ,
    .PAD_USI0_SCLK            ( PAD_USI0_SCLK               ) ,
    .PAD_USI0_SD0             ( PAD_USI0_SD0                ) ,
    .PAD_USI0_SD1             ( PAD_USI0_SD1                ) ,
    //.PAD_USI1_NSS             ( PAD_USI1_NSS                ) ,
    //.PAD_USI1_SCLK            ( PAD_USI1_SCLK               ) ,
    //.PAD_USI1_SD0             ( PAD_USI1_SD0                ) ,
    //.PAD_USI1_SD1             ( PAD_USI1_SD1                ) ,
    //.PAD_USI2_NSS             ( PAD_USI2_NSS                ) ,
    //.PAD_USI2_SCLK            ( PAD_USI2_SCLK               ) ,
    //.PAD_USI2_SD0             ( PAD_USI2_SD0                ) ,
    //.PAD_USI2_SD1             ( PAD_USI2_SD1                ) ,
    .PIN_EHS                  ( clk_20m                     ) ,
    .POUT_EHS                 ( POUT_EHS                    ) 
);


endmodule

