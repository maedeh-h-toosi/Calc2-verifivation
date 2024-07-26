`ifndef SV_INTERFACES
`define SV_INTERFACES

//create interface for DUV input
interface Port_Stimuli (
	output reg [0:3] req_cmd_in ,
	output reg [0:1] req_tag_in ,
	output reg [0:31] req_data_in
	
	);
endinterface

//create interface for DUV global input and ports
interface Port_Global(
	input reg c_clk ,
	output reg reset
	);
endinterface

//create interface for check output
interface Port_Checker(
	output wire [0:31] out_data,
	output wire [0:1] out_response,
	output wire [0:1] out_tag
	);
endinterface

`endif