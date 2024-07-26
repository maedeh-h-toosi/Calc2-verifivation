`include "Checker.sv"
`ifndef golden_model
`define golden_model

class golden_model;


 bit [0:32] Golden_Model_Result;


scoreboard Golden_sc ;

task calculate_input (
		bit [0:31] my_Input1,
		bit [0:31] my_Input2,
		bit [0:1] my_Tag,
		bit [0:3] my_Command,
		bit [1:4] my_portNumber);
  
    if (my_Command == 1)
	begin
        Golden_Model_Result = my_Input1 + my_Input2;
		
		/*if(Golden_Model_Result[32]==1)
			Response = 2;
		else 
			Response = 1;*/
		
	//GoldenModel_sc = new (my_Input1, my_Input2, my_Tag, 1, GoldenModelResult , port_Number);
	Golden_sc.store_data(my_Input1, my_Input2, my_Tag, my_Command, my_portNumber, Golden_Model_Result );
	end

    else if (my_Command == 2)
	begin
        Golden_Model_Result = my_Input1 - my_Input2;
		
		/*if(my_Input1 < my_Input2)
			Response = 2;
		else 
			Response = 1;*/
			
	//GoldenModel_sc = new (my_Input1, my_Input2, my_Tag, 2, GoldenModelResult , port_Number);
	Golden_sc.store_data(my_Input1, my_Input2, my_Tag, my_Command, my_portNumber, Golden_Model_Result);
	end
        
    else if (my_Command == 5)
	begin
        Golden_Model_Result = my_Input1 << my_Input2[27: 31];
		//Response =1 ;
	//GoldenModel_sc = new (my_Input1, my_Input2, my_Tag, 5, GoldenModelResult , port_Number);
	Golden_sc.store_data(my_Input1, my_Input2, my_Tag, my_Command, my_portNumber, Golden_Model_Result);
	end
        
    else if (my_Command == 6)
	begin
        Golden_Model_Result = my_Input1 >> my_Input2[27: 31];
		//Response = 1;
	//GoldenModel_sc = new (my_Input1, my_Input2, my_Tag, 6, GoldenModelResult , port_Number);
	Golden_sc.store_data(my_Input1, my_Input2, my_Tag, my_Command, my_portNumber, Golden_Model_Result );

	end
    else 
        Golden_Model_Result = 0; 
		//Response = 0;
	Golden_sc.store_data(my_Input1, my_Input2, my_Tag, my_Command, my_portNumber, Golden_Model_Result);
endtask

/////////////////////////////////////////////////////////////////////////////////////
                
/*task print_output_result ();

	if(my_Command == 1)
		$display("The random result for %h+%h=%h\n",my_Input1,my_Input2,GoldenModelResult);
	else if(my_Command == 2)
		$display("The random result for %h-%h=%h\n",my_Input1,my_Input2,GoldenModelResult);
	else if(my_Command == 5)
		$display("The random result for %h<<%h=%h\n",my_Input1,my_Input2,GoldenModelResult);
	else if(my_Command == 6)
		$display("The random result for %h>>%h=%h\n",my_Input1,my_Input2,GoldenModelResult);

endtask*/

/////////////////////////////////////////////////////////////

endclass

`endif