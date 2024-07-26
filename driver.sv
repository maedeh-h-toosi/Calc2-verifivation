`include "interface.sv"
`include "golden_model.sv"
//`include "scoreboard.sv"

class Driver;

//connect interface and create object

	int portNumber;
	virtual Port_Stimuli ports;
	virtual Port_Global globPorts;
	
	
	
function new (int _portNumber, virtual Port_Global _globPorts,
		virtual Port_Stimuli _ports 
		);
					
    begin
	
	this.ports = _ports;
	this.globPorts = _globPorts;
	this.portNumber = _portNumber;
    end
endfunction

golden_model G_Model = new();
//scoreboard SC_Model = new();
////////////////////////Create Add Command and function//////////////////////////////////	

task Add( int Input1, int Input2 , int Tag );
	begin 
		//SC_Model.get_free_tag(Tag);
		G_Model.calculate_input( Input1,Input2 , Tag ,1 ,portNumber);
		ports.req_cmd_in = 1;
		ports.req_data_in = Input1;
		ports.req_tag_in =Tag ;
		@(posedge globPorts.c_clk);
		ports.req_cmd_in = 0;
		ports.req_data_in = Input2;
		ports.req_tag_in = 0;
		@( posedge globPorts.c_clk) ; 
		ports.req_cmd_in = 0;
		ports.req_data_in = 0 ; 
		ports.req_tag_in =0 ;
	end
endtask


/////////////////////Create Sub Command and function/////////////////////////////////////	
task Sub( int Input1, int Input2 , int Tag );
	begin 
		
		//SC_Model.get_free_tag(Tag);
		G_Model.calculate_input( Input1,Input2 , Tag ,2 ,portNumber);
		ports.req_cmd_in = 2;
		ports.req_data_in =Input1 ; 
		ports.req_tag_in =Tag ;
		@(posedge globPorts.c_clk);
		ports.req_cmd_in = 0;
		ports.req_data_in = Input2;
		ports.req_tag_in = 0;
		@( posedge globPorts.c_clk) ; 
		ports.req_cmd_in = 0;
		ports.req_data_in = 0 ; 
		ports.req_tag_in =0 ;
	end
endtask
///////////////////////////Create shift left Command and function///////////////////////////////////	
task ShiftLeft( int Input1, int Input2 , int Tag );
	begin 
		
		//SC_Model.get_free_tag(Tag);
		G_Model.calculate_input( Input1,Input2 , Tag ,5 ,portNumber);
		ports.req_cmd_in = 5;
		ports.req_data_in =Input1 ;
		ports.req_tag_in =Tag ;
		@(posedge globPorts.c_clk);
		ports.req_cmd_in = 0;
		ports.req_data_in = Input2;
		ports.req_tag_in = 0;
		@( posedge globPorts.c_clk) ; 
		ports.req_cmd_in = 0;
		ports.req_data_in = 0 ; 
		ports.req_tag_in =0 ;
	end
endtask
//////////////////////Create shift right Command and function////////////////////////////////	
task ShiftRight( int Input1, int Input2 , int Tag);
	begin 
		//SC_Model.get_free_tag(Tag);
		G_Model.calculate_input( Input1,Input2 , Tag ,6 ,portNumber);
		ports.req_cmd_in =6;
		ports.req_data_in = Input1; 
		ports.req_tag_in =Tag ;
		@(posedge globPorts.c_clk);
		ports.req_cmd_in = 0;
		ports.req_data_in = Input2;
		ports.req_tag_in = 0;
		@(posedge globPorts.c_clk) ; 
		ports.req_cmd_in = 0;
		ports.req_data_in = 0 ; 
		ports.req_tag_in =0 ;
	end
endtask
//////////////////////////////////////////////////////////////////////////////////	
task Random_Input( int Input1, int Input2 , int Tag ,int Command);
	begin 
		//SC_Model.get_free_tag(Tag);
		G_Model.calculate_input( Input1,Input2 , Tag ,Command ,portNumber);
		ports.req_cmd_in = Command;
		ports.req_data_in = Input1;
		ports.req_tag_in =Tag ;
		@(posedge globPorts.c_clk);
		ports.req_cmd_in = 0;
		ports.req_data_in = Input2;
		ports.req_tag_in = 0;
		@( posedge globPorts.c_clk) ; 
		ports.req_cmd_in = 0;
		ports.req_data_in = 0 ; 
		ports.req_tag_in =0 ;
	end
endtask


endclass