`include "interface.sv"
`include "top_test.sv"
`include "calc2_top.v"



module my_test_bench ;
//connect module to design here

   wire [0:31] out_data1, out_data2, out_data3, out_data4;
   wire [0:1] out_resp1, out_resp2, out_resp3, out_resp4, out_tag1, out_tag2, out_tag3, out_tag4;
   wire scan_out;

   reg [0:3]  req1_cmd_in, req2_cmd_in, req3_cmd_in, req4_cmd_in;
   reg [0:1]  req1_tag_in, req2_tag_in, req3_tag_in, req4_tag_in;
   reg [0:31] req1_data_in, req2_data_in, req3_data_in, req4_data_in;
   reg  scan_in, a_clk, b_clk, main_clk;

//instance interface

	Port_Stimuli Port1_test(req1_cmd_in,req1_tag_in,req1_data_in);
	Port_Stimuli Port2_test(req2_cmd_in,req2_tag_in,req2_data_in);
	Port_Stimuli Port3_test(req3_cmd_in,req3_tag_in,req3_data_in);
	Port_Stimuli Port4_test(req4_cmd_in,req4_tag_in,req4_data_in);
	
	Port_Checker Port_1_check(out_data1,out_resp1,out_tag1);
	Port_Checker Port_2_check(out_data2,out_resp2,out_tag2);
	Port_Checker Port_3_check(out_data3,out_resp3,out_tag3);
	Port_Checker Port_4_check(out_data4,out_resp4,out_tag4); 

	Port_Global Port_Global (main_clk,reset);




top_test my_generator (
		.Global (Port_Global) ,
		.Port_1 (Port1_test),
		.Port_2 (Port2_test),
		.Port_3 (Port3_test),
		.Port_4 (Port4_test),

		.Checker_Port1(Port_1_check) ,
		.Checker_Port2(Port_2_check) ,
		.Checker_Port3(Port_3_check) ,
		.Checker_Port4(Port_4_check) 
		); 
//instance design

calc2_top my_calc2(.out_data1(out_data1) ,
  .out_data2(out_data2) ,
  .out_data3(out_data3) ,
  .out_data4(out_data4) ,
  .out_resp1(out_resp1) ,
  .out_resp2(out_resp2) ,
  .out_resp3(out_resp3) ,
  .out_resp4(out_resp4) ,
  .out_tag1(out_tag1) ,
  .out_tag2(out_tag2) ,
  .out_tag3(out_tag3) ,
  .out_tag4(out_tag4) ,
  .scan_out(scan_out),
  .scan_in(scan_in),
  .a_clk(a_clk),
  .b_clk(b_clk),
  .c_clk(main_clk),
  .reset(reset) ,
  .req1_cmd_in(req1_cmd_in) ,
  .req2_cmd_in(req2_cmd_in) ,
  .req3_cmd_in(req3_cmd_in) ,
  .req4_cmd_in(req4_cmd_in) ,
  .req1_tag_in(req1_tag_in) ,
  .req2_tag_in(req2_tag_in) ,
  .req3_tag_in(req3_tag_in) ,
  .req4_tag_in(req4_tag_in) ,
  .req1_data_in(req1_data_in) ,
  .req2_data_in(req2_data_in) ,
  .req3_data_in(req3_data_in) ,
  .req4_data_in(req4_data_in));

initial begin
	main_clk =1'b0;
	a_clk =1'b0;
	b_clk =1'b0;
	scan_in=1'b0;
  	forever #10 main_clk = ~ main_clk;
 end


endmodule





