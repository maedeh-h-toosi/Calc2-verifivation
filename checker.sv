`ifndef Checker
`define Checker
`include "scoreboard.sv"
class Checker;

	virtual Port_Checker port_checker;
	virtual Port_Global glob;
	int file_pointer; // for write result in file
	int Port_Number;
	string cmd_string;	
	event Finish;


 scoreboard ScoreBoard_ch = new();
 
 
 
///***************** Define expected value on port1 ******************************///

 bit [0:3]   expected_Command_Add_Sub_Port_1;
 bit [0:1]   expected_Tag_Add_Sub_Port_1;
 bit [0:31]  expected_Input1_Add_Sub_Port_1;
 bit [0:31]  expected_Input2_Add_Sub_Port_1;
 bit [0:32] expected_Data_Add_Sub_Port_1;
	
 bit [0:3]   expected_Command_Shift_Port_1;
 bit [0:1]   expected_Tag_Shift_Port_1;
 bit [0:31]  expected_Input1_Shift_Port_1;
 bit [0:31]  expected_Input2_Shift_Port_1;
 bit [0:32] expected_Data_Shift_Port_1;

 bit [0:3]   expected_Command_Invalid_Port_1;
 bit [0:1]   expected_Tag_Invalid_Port_1;
 bit [0:31]  expected_Input1_Invalid_Port_1;
 bit [0:31]  expected_Input2_Invalid_Port_1;
 bit [0:32] expected_Data_Invalid_Port_1;

///***************** Define expected value on port2 ******************************///

 bit [0:3]   expected_Command_Add_Sub_Port_2;
 bit [0:1]   expected_Tag_Add_Sub_Port_2;
 bit [0:31]  expected_Input1_Add_Sub_Port_2;
 bit [0:31]  expected_Input2_Add_Sub_Port_2;
 bit [0:32] expected_Data_Add_Sub_Port_2;
  
 bit [0:3]   expected_Command_Shift_Port_2;
 bit [0:1]   expected_Tag_Shift_Port_2;
 bit [0:31]  expected_Input1_Shift_Port_2;
 bit [0:31]  expected_Input2_Shift_Port_2;
 bit [0:32] expected_Data_Shift_Port_2;

 bit [0:3]   expected_Command_Invalid_Port_2;
 bit [0:1]   expected_Tag_Invalid_Port_2;
 bit [0:31]  expected_Input1_Invalid_Port_2;
 bit [0:31]  expected_Input2_Invalid_Port_2;
 bit [0:32] expected_Data_Invalid_Port_2;

 
 ///***************** Define expected value on port3 ******************************///
 
 bit [0:3]   expected_Command_Add_Sub_Port_3;
 bit [0:1]   expected_Tag_Add_Sub_Port_3;
 bit [0:31]  expected_Input1_Add_Sub_Port_3;
 bit [0:31]  expected_Input2_Add_Sub_Port_3;
 bit [0:32] expected_Data_Add_Sub_Port_3;
	
 bit [0:3]   expected_Command_Shift_Port_3;
 bit [0:1]   expected_Tag_Shift_Port_3;
 bit [0:31]  expected_Input1_Shift_Port_3;
 bit [0:31]  expected_Input2_Shift_Port_3;
 bit [0:32] expected_Data_Shift_Port_3;

 bit [0:3]   expected_Command_Invalid_Port_3;
 bit [0:1]   expected_Tag_Invalid_Port_3;
 bit [0:31]  expected_Input1_Invalid_Port_3;
 bit [0:31]  expected_Input2_Invalid_Port_3;
 bit [0:32] expected_Data_Invalid_Port_3;
 
 ///***************** Define expected value on port4 ******************************///
 
 bit [0:3]   expected_Command_Add_Sub_Port_4;
 bit [0:1]   expected_Tag_Add_Sub_Port_4;
 bit [0:31]  expected_Input1_Add_Sub_Port_4;
 bit [0:31]  expected_Input2_Add_Sub_Port_4;
 bit [0:32] expected_Data_Add_Sub_Port_4;
	
 bit [0:3]   expected_Command_Shift_Port_4;
 bit [0:1]   expected_Tag_Shift_Port_4;
 bit [0:31]  expected_Input1_Shift_Port_4;
 bit [0:31]  expected_Input2_Shift_Port_4;
 bit [0:32] expected_Data_Shift_Port_4;

 bit [0:3]   expected_Command_Invalid_Port_4;
 bit [0:1]   expected_Tag_Invalid_Port_4;
 bit [0:31]  expected_Input1_Invalid_Port_4;
 bit [0:31]  expected_Input2_Invalid_Port_4;
 bit [0:32] expected_Data_Invalid_Port_4;


///***************** Define expected value on ports ******************************///

 bit [0:1]   temp_Tag_Add_Sub_Port_1;
 bit [0:1]   temp_Tag_Shift_Port_1;
 bit [0:1]   temp_Tag_Invalid_Port_1;
 
  bit [0:1]   temp_Tag_Add_Sub_Port_2;
 bit [0:1]   temp_Tag_Shift_Port_2;
 bit [0:1]   temp_Tag_Invalid_Port_2;
 
  bit [0:1]   temp_Tag_Add_Sub_Port_3;
 bit [0:1]   temp_Tag_Shift_Port_3;
 bit [0:1]   temp_Tag_Invalid_Port_3;
 
  bit [0:1]   temp_Tag_Add_Sub_Port_4;
 bit [0:1]   temp_Tag_Shift_Port_4;
 bit [0:1]   temp_Tag_Invalid_Port_4;

 




function  new(int _Port_Number , virtual Port_Checker _port_ch, virtual Port_Global _glob , event _Finish);
	begin
		this.Port_Number = _Port_Number;
		this.port_checker = _port_ch;
		this.glob = _glob;
		this.Finish = _Finish;
	end	
endfunction


task Start();

begin //task

	file_pointer = $fopen("Checker_Reoprt_file.txt","w");

	forever begin @( negedge  glob.c_clk ) //begin forever
	 //checker
	
/////**********************successful verification *********************/////

 	if(port_checker.out_response == 1 ) 
	begin //resp1
	
	if(Port_Number ==1) begin // port1
		if( ScoreBoard_ch.q_Tag_add_sub_Port_1.size() > 0)
		begin  //1  Check add/sub queue
			
				temp_Tag_Add_Sub_Port_1 = ScoreBoard_ch.q_Tag_add_sub_Port_1[$]; // store last elemant of queue in value
			
			if( temp_Tag_Add_Sub_Port_1 == port_checker.out_tag) 
				begin //2
					expected_Tag_Add_Sub_Port_1 = ScoreBoard_ch.q_Tag_add_sub_Port_1.pop_back();
					expected_Data_Add_Sub_Port_1 = ScoreBoard_ch.q_GoldenModelResult_add_sub_Port_1.pop_back();
					expected_Command_Add_Sub_Port_1 = ScoreBoard_ch.q_Command_add_sub_Port_1.pop_back();
					expected_Input1_Add_Sub_Port_1 = ScoreBoard_ch.q_Input1_add_sub_Port_1.pop_back();
					expected_Input2_Add_Sub_Port_1 = ScoreBoard_ch.q_Input2_add_sub_Port_1.pop_back();
					//expected_Response_Add_Sub_Port_1 = ScoreBoard_ch.q_Response_add_sub_Port_1.pop_back() ;
					//$display("Port1 Pop Results for Add/Sub Queue = %p", ScoreBoard_ch.q_GoldenModelResult_add_sub_Port_1);
					
					if ( port_checker.out_data == expected_Data_Add_Sub_Port_1 )
						begin
							convert_string(expected_Command_Add_Sub_Port_1);
							$display("@%0t successful verification at %h %s %h on port:%0d \n",$time,	expected_Input1_Add_Sub_Port_1,cmd_string,expected_Input2_Add_Sub_Port_1,Port_Number);
							$fwrite(file_pointer,"successful verification at %h %s %h on port:%0d \n",expected_Input1_Add_Sub_Port_1,cmd_string,expected_Input2_Add_Sub_Port_1,Port_Number);
						end
					else begin
							convert_string(expected_Command_Add_Sub_Port_1);
							$display("@%0t unsuccessful verification at %h %s %h on port:%0d \n",$time,expected_Input1_Add_Sub_Port_1,cmd_string,expected_Input2_Add_Sub_Port_1,Port_Number);
							$fwrite(file_pointer,"unsuccessful verification at %h %s %h on port:%0d \n",expected_Input1_Add_Sub_Port_1,cmd_string,expected_Input2_Add_Sub_Port_1,Port_Number);
						end
					
				end //2	
				
		end	//1		Check shift queue
		if ( ScoreBoard_ch.q_Tag_shift_Port_1.size() > 0 ) 
			begin //1

					temp_Tag_Shift_Port_1 = ScoreBoard_ch.q_Tag_shift_Port_1[$]; // store last elemant of queue in value
		
			if( temp_Tag_Shift_Port_1 == port_checker.out_tag) 
				begin //2
					expected_Tag_Shift_Port_1 = ScoreBoard_ch.q_Tag_shift_Port_1.pop_back();
					expected_Data_Shift_Port_1 = ScoreBoard_ch.q_GoldenModelResult_shift_Port_1.pop_back();
					expected_Command_Shift_Port_1 = ScoreBoard_ch.q_Command_shift_Port_1.pop_back();
					expected_Input1_Shift_Port_1 = ScoreBoard_ch.q_Input1_shift_Port_1.pop_back();
					expected_Input2_Shift_Port_1 = ScoreBoard_ch.q_Input2_shift_Port_1.pop_back();
					//$display("Port1 Pop Results for Shift Queue = %p",ScoreBoard_ch.q_GoldenModelResult_shift_Port_1);
					
					if (  port_checker.out_data == expected_Data_Shift_Port_1 )
						begin
							convert_string(expected_Command_Shift_Port_1);
							$display("@%0t successful verification at %h %s %h on port:%0d \n",$time,		expected_Input1_Shift_Port_1,cmd_string,expected_Input2_Shift_Port_1,Port_Number);
							$fwrite(file_pointer,"successful verification at %h %s %h on port:%0d \n",		expected_Input1_Shift_Port_1,cmd_string,expected_Input2_Shift_Port_1,Port_Number);
						end
					else begin //3
				
							convert_string(expected_Command_Shift_Port_1);
							$display("@%0t unsuccessful verification at %h %s %h on port:%0d \n",$time,		expected_Input1_Shift_Port_1,cmd_string,expected_Input2_Shift_Port_1,Port_Number);
							$fwrite(file_pointer,"unsuccessful verification at %h %s %h on port:%0d \n",		expected_Input1_Shift_Port_1,cmd_string,expected_Input2_Shift_Port_1,Port_Number);
					end //3

				end	//2		
		
			end //1
			
			
			 if ( ScoreBoard_ch.q_Tag_invalid_Port_1.size() > 0 ) 
			begin //1

				temp_Tag_Invalid_Port_1 = ScoreBoard_ch.q_Tag_invalid_Port_1[$];
		
				if( temp_Tag_Invalid_Port_1 == port_checker.out_tag) 
				begin //2
					expected_Tag_Invalid_Port_1 = ScoreBoard_ch.q_Tag_invalid_Port_1.pop_back();
					expected_Data_Invalid_Port_1 = ScoreBoard_ch.q_GoldenModelResult_invalid_Port_1.pop_back();
					expected_Command_Invalid_Port_1 = ScoreBoard_ch.q_Command_invalid_Port_1.pop_back();
					expected_Input1_Invalid_Port_1 = ScoreBoard_ch.q_Input1_invalid_Port_1.pop_back();
					expected_Input2_Invalid_Port_1 = ScoreBoard_ch.q_Input2_invalid_Port_1.pop_back();
					//expected_Response_Invalid_Port_1 = ScoreBoard_ch.q_Response_invalid_Port_1.pop_back() ;
					
					if (  port_checker.out_data == expected_Data_Invalid_Port_1 )
						begin
							$display("@%0t invalid data on port: %0d \n",$time ,Port_Number); 
							$write(file_pointer,"invalid data on port: %0d \n" ,Port_Number);
						end
					else begin
					$display("@%0t Error invalid data on port %0d \n" ,$time, Port_Number);
					$write(file_pointer,"Error invalid data on port %0d \n" , Port_Number);
					end
				
				end//2
			end	//1	
			
	end // port1
	
	
///////////////***************test port Number 2 ****************////////////
if(Port_Number == 2 ) begin // port2
		if( ScoreBoard_ch.q_Tag_add_sub_Port_2.size() > 0)
		begin  //1  Check add/sub queue
			
				temp_Tag_Add_Sub_Port_2 = ScoreBoard_ch.q_Tag_add_sub_Port_2[$]; // store last elemant of queue in value
			
			if( temp_Tag_Add_Sub_Port_2 == port_checker.out_tag) 
				begin //2
					expected_Tag_Add_Sub_Port_2 = ScoreBoard_ch.q_Tag_add_sub_Port_2.pop_back();
					expected_Data_Add_Sub_Port_2 = ScoreBoard_ch.q_GoldenModelResult_add_sub_Port_2.pop_back();
					expected_Command_Add_Sub_Port_2 = ScoreBoard_ch.q_Command_add_sub_Port_2.pop_back();
					expected_Input1_Add_Sub_Port_2 = ScoreBoard_ch.q_Input1_add_sub_Port_2.pop_back();
					expected_Input2_Add_Sub_Port_2 = ScoreBoard_ch.q_Input2_add_sub_Port_2.pop_back();
					//expected_Response_Add_Sub_Port_2 = ScoreBoard_ch.q_Response_add_sub_Port_2.pop_back() ;
					//$display("Port2 Pop Results for Add/Sub Queue = %p", ScoreBoard_ch.q_GoldenModelResult_add_sub_Port_2);
					
					if ( port_checker.out_data == expected_Data_Add_Sub_Port_2 )
						begin
							
							convert_string(expected_Command_Add_Sub_Port_2);
							$display("@%0t successful verification at %h %s %h on port:%0d \n",$time,	expected_Input1_Add_Sub_Port_2,cmd_string,expected_Input2_Add_Sub_Port_2,Port_Number);
							$fwrite(file_pointer,"successful verification at %h %s %h on port:%0d \n",expected_Input1_Add_Sub_Port_2,cmd_string,expected_Input2_Add_Sub_Port_2,Port_Number);
						end
					else begin

							convert_string(expected_Command_Add_Sub_Port_2);
							$display("@%0t unsuccessful verification at %h %s %h on port:%0d \n",$time,expected_Input1_Add_Sub_Port_2,cmd_string,expected_Input2_Add_Sub_Port_2,Port_Number);
							$fwrite(file_pointer,"unsuccessful verification at %h %s %h on port:%0d \n",expected_Input1_Add_Sub_Port_2,cmd_string,expected_Input2_Add_Sub_Port_2,Port_Number);
						end
					
				end //2	
				
		end	//1		Check shift queue
		if ( ScoreBoard_ch.q_Tag_shift_Port_2.size() > 0 ) 
			begin //1

					temp_Tag_Shift_Port_2 = ScoreBoard_ch.q_Tag_shift_Port_2[$]; // store last elemant of queue in value
		
			if( temp_Tag_Shift_Port_2 == port_checker.out_tag) 
				begin //2
					expected_Tag_Shift_Port_2 = ScoreBoard_ch.q_Tag_shift_Port_2.pop_back();
					expected_Data_Shift_Port_2 = ScoreBoard_ch.q_GoldenModelResult_shift_Port_2.pop_back();
					expected_Command_Shift_Port_2 = ScoreBoard_ch.q_Command_shift_Port_2.pop_back();
					expected_Input1_Shift_Port_2 = ScoreBoard_ch.q_Input1_shift_Port_2.pop_back();
					expected_Input2_Shift_Port_2 = ScoreBoard_ch.q_Input2_shift_Port_2.pop_back();
					//expected_Response_Shift_Port_2 = ScoreBoard_ch.q_Response_shift_Port_2.pop_back() ;
					//$display("Port2 Pop Results for Shift Queue = %p",ScoreBoard_ch.q_GoldenModelResult_shift_Port_2);
					
					if (  port_checker.out_data == expected_Data_Shift_Port_2 )
						begin
	
							convert_string(expected_Command_Shift_Port_2);
							$display("@%0t successful verification at %h %s %h on port:%0d \n",$time,		expected_Input1_Shift_Port_2,cmd_string,expected_Input2_Shift_Port_2,Port_Number);
							$fwrite(file_pointer,"successful verification at %h %s %h on port:%0d \n",		expected_Input1_Shift_Port_2,cmd_string,expected_Input2_Shift_Port_2,Port_Number);
						end
					else begin //3
	
							convert_string(expected_Command_Shift_Port_2);
							$display("@%0t unsuccessful verification at %h %s %h on port:%0d \n",$time,		expected_Input1_Shift_Port_2,cmd_string,expected_Input2_Shift_Port_2,Port_Number);
							$fwrite(file_pointer,"unsuccessful verification at %h %s %h on port:%0d \n",		expected_Input1_Shift_Port_2,cmd_string,expected_Input2_Shift_Port_2,Port_Number);
					end //3

				end	//2		
		
			end //1
			
			
			if ( ScoreBoard_ch.q_Tag_invalid_Port_2.size() > 0 ) 
			begin //1

				temp_Tag_Invalid_Port_2 = ScoreBoard_ch.q_Tag_invalid_Port_2[$];
		
				if( temp_Tag_Invalid_Port_2 == port_checker.out_tag) 
				begin //2
					expected_Tag_Invalid_Port_2 = ScoreBoard_ch.q_Tag_invalid_Port_2.pop_back();
					expected_Data_Invalid_Port_2 = ScoreBoard_ch.q_GoldenModelResult_invalid_Port_2.pop_back();
					expected_Command_Invalid_Port_2 = ScoreBoard_ch.q_Command_invalid_Port_2.pop_back();
					expected_Input1_Invalid_Port_2 = ScoreBoard_ch.q_Input1_invalid_Port_2.pop_back();
					expected_Input2_Invalid_Port_2 = ScoreBoard_ch.q_Input2_invalid_Port_2.pop_back();

					
					if (  port_checker.out_data == expected_Data_Invalid_Port_2 )
						begin
							$display("@%0t invalid data on port: %0d \n",$time ,Port_Number); 
							$write(file_pointer,"invalid data on port: %0d \n" ,Port_Number);
						end
					else begin
					$display("@%0t Error invalid data on port %0d \n" ,$time, Port_Number);
					$write(file_pointer,"Error invalid data on port %0d \n" , Port_Number);
					end
				
				end//2
			end	//1	
			
	end // port2

///////////////***************test port Number 3 ****************////////////
if(Port_Number == 3 ) begin // port3
		if( ScoreBoard_ch.q_Tag_add_sub_Port_3.size() > 0)
		begin  //1  Check add/sub queue
			
				temp_Tag_Add_Sub_Port_3 = ScoreBoard_ch.q_Tag_add_sub_Port_3[$]; // store last elemant of queue in value
			
			if( temp_Tag_Add_Sub_Port_3 == port_checker.out_tag) 
				begin //2
					expected_Tag_Add_Sub_Port_3 = ScoreBoard_ch.q_Tag_add_sub_Port_3.pop_back();
					expected_Data_Add_Sub_Port_3 = ScoreBoard_ch.q_GoldenModelResult_add_sub_Port_3.pop_back();
					expected_Command_Add_Sub_Port_3 = ScoreBoard_ch.q_Command_add_sub_Port_3.pop_back();
					expected_Input1_Add_Sub_Port_3 = ScoreBoard_ch.q_Input1_add_sub_Port_3.pop_back();
					expected_Input2_Add_Sub_Port_3 = ScoreBoard_ch.q_Input2_add_sub_Port_3.pop_back();
					
					//$display("Port3 Pop Results for Add/Sub Queue = %p", ScoreBoard_ch.q_GoldenModelResult_add_sub_Port_3);
					
					if ( port_checker.out_data == expected_Data_Add_Sub_Port_3 )
						begin
			
							convert_string(expected_Command_Add_Sub_Port_3);
							$display("@%0t successful verification at %h %s %h on port:%0d \n",$time,	expected_Input1_Add_Sub_Port_3,cmd_string,expected_Input2_Add_Sub_Port_3,Port_Number);
							$fwrite(file_pointer,"successful verification at %h %s %h on port:%0d \n",expected_Input1_Add_Sub_Port_3,cmd_string,expected_Input2_Add_Sub_Port_3,Port_Number);
						end
					else begin
				
							convert_string(expected_Command_Add_Sub_Port_3);
							$display("@%0t unsuccessful verification at %h %s %h on port:%0d \n",$time,expected_Input1_Add_Sub_Port_3,cmd_string,expected_Input2_Add_Sub_Port_3,Port_Number);
							$fwrite(file_pointer,"unsuccessful verification at %h %s %h on port:%0d \n",expected_Input1_Add_Sub_Port_3,cmd_string,expected_Input2_Add_Sub_Port_3,Port_Number);
						end
					
				end //2	
				
		end	//1		Check shift queue
		 if ( ScoreBoard_ch.q_Tag_shift_Port_3.size() > 0 ) 
			begin //1

					temp_Tag_Shift_Port_3 = ScoreBoard_ch.q_Tag_shift_Port_3[$]; // store last elemant of queue in value
		
			if( temp_Tag_Shift_Port_3 == port_checker.out_tag) 
				begin //2
					expected_Tag_Shift_Port_3 = ScoreBoard_ch.q_Tag_shift_Port_3.pop_back();
					expected_Data_Shift_Port_3 = ScoreBoard_ch.q_GoldenModelResult_shift_Port_3.pop_back();
					expected_Command_Shift_Port_3 = ScoreBoard_ch.q_Command_shift_Port_3.pop_back();
					expected_Input1_Shift_Port_3 = ScoreBoard_ch.q_Input1_shift_Port_3.pop_back();
					expected_Input2_Shift_Port_3 = ScoreBoard_ch.q_Input2_shift_Port_3.pop_back();
					//expected_Response_Shift_Port_3 = ScoreBoard_ch.q_Response_shift_Port_3.pop_back() ;
					//$display("Port3 Pop Results for Shift Queue = %p",ScoreBoard_ch.q_GoldenModelResult_shift_Port_3);
					
					if (  port_checker.out_data == expected_Data_Shift_Port_3 )
						begin
							/*case(expected_Command_Shift_Port_3)
							4'b0001: cmd_string ="+";
							4'b0010: cmd_string ="-";
							4'b0101: cmd_string ="<<";
							4'b0110: cmd_string =">>";
							endcase*/
							convert_string(expected_Command_Shift_Port_3);
							$display("@%0t successful verification at %h %s %h on port:%0d \n",$time,		expected_Input1_Shift_Port_3,cmd_string,expected_Input2_Shift_Port_3,Port_Number);
							$fwrite(file_pointer,"successful verification at %h %s %h on port:%0d \n",		expected_Input1_Shift_Port_3,cmd_string,expected_Input2_Shift_Port_3,Port_Number);
						end
					else begin //3

							convert_string(expected_Command_Shift_Port_3);
							$display("@%0t unsuccessful verification at %h %s %h on port:%0d \n",$time,		expected_Input1_Shift_Port_3,cmd_string,expected_Input2_Shift_Port_3,Port_Number);
							$fwrite(file_pointer,"unsuccessful verification at %h %s %h on port:%0d \n",		expected_Input1_Shift_Port_3,cmd_string,expected_Input2_Shift_Port_3,Port_Number);
					end //3

				end	//2		
		
			end //1
			
			
			 if ( ScoreBoard_ch.q_Tag_invalid_Port_3.size() > 0 ) 
			begin //1

				temp_Tag_Invalid_Port_3 = ScoreBoard_ch.q_Tag_invalid_Port_3[$];
		
				if( temp_Tag_Invalid_Port_3 == port_checker.out_tag) 
				begin //2
					expected_Tag_Invalid_Port_3 = ScoreBoard_ch.q_Tag_invalid_Port_3.pop_back();
					expected_Data_Invalid_Port_3 = ScoreBoard_ch.q_GoldenModelResult_invalid_Port_3.pop_back();
					expected_Command_Invalid_Port_3 = ScoreBoard_ch.q_Command_invalid_Port_3.pop_back();
					expected_Input1_Invalid_Port_3 = ScoreBoard_ch.q_Input1_invalid_Port_3.pop_back();
					expected_Input2_Invalid_Port_3 = ScoreBoard_ch.q_Input2_invalid_Port_3.pop_back();
					
					if (  port_checker.out_data == expected_Data_Invalid_Port_3 )
						begin
							$display("@%0t invalid data on port: %0d \n",$time ,Port_Number); 
							$write(file_pointer,"invalid data on port: %0d \n" ,Port_Number);
						end
					else begin
					$display("@%0t Error invalid data on port %0d \n" ,$time, Port_Number);
					$write(file_pointer,"Error invalid data on port %0d \n" , Port_Number);
					end
				
				end//2
			end	//1	
			
	end // port3

///////////////***************test port Number 4 ****************////////////	
if(Port_Number == 4 ) begin // port4
		if( ScoreBoard_ch.q_Tag_add_sub_Port_4.size() > 0)
		begin  //1  Check add/sub queue
			
				temp_Tag_Add_Sub_Port_4 = ScoreBoard_ch.q_Tag_add_sub_Port_4[$]; // store last elemant of queue in value
			
			if( temp_Tag_Add_Sub_Port_4 == port_checker.out_tag) 
				begin //2
					expected_Tag_Add_Sub_Port_4 = ScoreBoard_ch.q_Tag_add_sub_Port_4.pop_back();
					expected_Data_Add_Sub_Port_4 = ScoreBoard_ch.q_GoldenModelResult_add_sub_Port_4.pop_back();
					expected_Command_Add_Sub_Port_4 = ScoreBoard_ch.q_Command_add_sub_Port_4.pop_back();
					expected_Input1_Add_Sub_Port_4 = ScoreBoard_ch.q_Input1_add_sub_Port_4.pop_back();
					expected_Input2_Add_Sub_Port_4 = ScoreBoard_ch.q_Input2_add_sub_Port_4.pop_back();
				
					//$display("Port4 Pop Results for Add/Sub Queue = %p", ScoreBoard_ch.q_GoldenModelResult_add_sub_Port_4);
					
					if ( port_checker.out_data == expected_Data_Add_Sub_Port_4 )
						begin
							convert_string(expected_Command_Add_Sub_Port_4);
							$display("@%0t successful verification at %h %s %h on port:%0d \n",$time,	expected_Input1_Add_Sub_Port_4,cmd_string,expected_Input2_Add_Sub_Port_4,Port_Number);
							$fwrite(file_pointer,"successful verification at %h %s %h on port:%0d \n",expected_Input1_Add_Sub_Port_4,cmd_string,expected_Input2_Add_Sub_Port_4,Port_Number);
						end
					else begin
							convert_string(expected_Command_Add_Sub_Port_4);
							$display("@%0t unsuccessful verification at %h %s %h on port:%0d \n",$time,expected_Input1_Add_Sub_Port_4,cmd_string,expected_Input2_Add_Sub_Port_4,Port_Number);
							$fwrite(file_pointer,"unsuccessful verification at %h %s %h on port:%0d \n",expected_Input1_Add_Sub_Port_4,cmd_string,expected_Input2_Add_Sub_Port_4,Port_Number);
						end
					
				end //2	
				
		end	//1		Check shift queue
		 if ( ScoreBoard_ch.q_Tag_shift_Port_4.size() > 0 ) 
			begin //1

					temp_Tag_Shift_Port_4 = ScoreBoard_ch.q_Tag_shift_Port_4[$]; // store last elemant of queue in value
		
			if( temp_Tag_Shift_Port_4 == port_checker.out_tag) 
				begin //2
					expected_Tag_Shift_Port_4 = ScoreBoard_ch.q_Tag_shift_Port_4.pop_back();
					expected_Data_Shift_Port_4 = ScoreBoard_ch.q_GoldenModelResult_shift_Port_4.pop_back();
					expected_Command_Shift_Port_4 = ScoreBoard_ch.q_Command_shift_Port_4.pop_back();
					expected_Input1_Shift_Port_4 = ScoreBoard_ch.q_Input1_shift_Port_4.pop_back();
					expected_Input2_Shift_Port_4 = ScoreBoard_ch.q_Input2_shift_Port_4.pop_back();
					
					//$display("Port1 Pop Results for Shift Queue = %p",ScoreBoard_ch.q_GoldenModelResult_shift_Port_4);
					
					if (  port_checker.out_data == expected_Data_Shift_Port_4 )
						begin
							convert_string(expected_Command_Shift_Port_4);
							$display("@%0t successful verification at %h %s %h on port:%0d \n",$time,		expected_Input1_Shift_Port_4,cmd_string,expected_Input2_Shift_Port_4,Port_Number);
							$fwrite(file_pointer,"successful verification at %h %s %h on port:%0d \n",		expected_Input1_Shift_Port_4,cmd_string,expected_Input2_Shift_Port_4,Port_Number);
						end
					else begin //3
							convert_string(expected_Command_Shift_Port_4);
							$display("@%0t unsuccessful verification at %h %s %h on port:%0d \n",$time,		expected_Input1_Shift_Port_4,cmd_string,expected_Input2_Shift_Port_4,Port_Number);
							$fwrite(file_pointer,"unsuccessful verification at %h %s %h on port:%0d \n",		expected_Input1_Shift_Port_4,cmd_string,expected_Input2_Shift_Port_4,Port_Number);
					end //3

				end	//2		
		
			end //1
			
			
			if ( ScoreBoard_ch.q_Tag_invalid_Port_4.size() > 0 ) 
			begin //1

				temp_Tag_Invalid_Port_4 = ScoreBoard_ch.q_Tag_invalid_Port_4[$];
		
				if( temp_Tag_Invalid_Port_4 == port_checker.out_tag) 
				begin //2
					expected_Tag_Invalid_Port_4 = ScoreBoard_ch.q_Tag_invalid_Port_4.pop_back();
					expected_Data_Invalid_Port_4 = ScoreBoard_ch.q_GoldenModelResult_invalid_Port_4.pop_back();
					expected_Command_Invalid_Port_4 = ScoreBoard_ch.q_Command_invalid_Port_4.pop_back();
					expected_Input1_Invalid_Port_4 = ScoreBoard_ch.q_Input1_invalid_Port_4.pop_back();
					expected_Input2_Invalid_Port_4 = ScoreBoard_ch.q_Input2_invalid_Port_4.pop_back();
					
					
					if (  port_checker.out_data == expected_Data_Invalid_Port_4 )
						begin
							$display("@%0t invalid data on port: %0d \n",$time ,Port_Number); 
							$write(file_pointer,"invalid data on port: %0d \n" ,Port_Number);
						end
					else begin
					$display("@%0t Error invalid data on port %0d \n" ,$time, Port_Number);
					$write(file_pointer,"Error invalid data on port %0d \n" , Port_Number);
					end
				
				end//2
			end	//1	
			
	end // port2

///////////////////////////////	
end //resp1

///////////////////////Overflow_Underflow_invalid///////////////

else if(port_checker.out_response == 2)begin // resp2

///////////////***************test port Number 1 ****************////////////			
	if(Port_Number ==1) begin //1
		if( ScoreBoard_ch.q_Tag_add_sub_Port_1.size() > 0) 
			begin  //2
			
				temp_Tag_Add_Sub_Port_1 = ScoreBoard_ch.q_Tag_add_sub_Port_1[$];
			
			if( temp_Tag_Add_Sub_Port_1 == port_checker.out_tag  ) 
				begin //3
					expected_Tag_Add_Sub_Port_1 = ScoreBoard_ch.q_Tag_add_sub_Port_1.pop_back();
					expected_Data_Add_Sub_Port_1 = ScoreBoard_ch.q_GoldenModelResult_add_sub_Port_1.pop_back();
					expected_Command_Add_Sub_Port_1 = ScoreBoard_ch.q_Command_add_sub_Port_1.pop_back();
					expected_Input1_Add_Sub_Port_1 = ScoreBoard_ch.q_Input1_add_sub_Port_1.pop_back();
					expected_Input2_Add_Sub_Port_1 = ScoreBoard_ch.q_Input2_add_sub_Port_1.pop_back();
		
					
					if ( expected_Command_Add_Sub_Port_1== 1 && expected_Data_Add_Sub_Port_1[32]==1)
						begin
							$display("@%0t Overflow at %h + %h on port:%0d \n",$time,expected_Input1_Add_Sub_Port_1,expected_Input2_Add_Sub_Port_1,Port_Number);
							$fwrite(file_pointer,"Overflow at %h + %h on port:%0d \n",expected_Input1_Add_Sub_Port_1,expected_Input2_Add_Sub_Port_1,Port_Number);
						end
					if (  expected_Command_Add_Sub_Port_2 == 2 && expected_Input1_Add_Sub_Port_1 <											expected_Input2_Add_Sub_Port_1 )
						begin
							$display("@%0t Underflow at %h - %h on port:%0d \n",$time,expected_Input1_Add_Sub_Port_1,expected_Input2_Add_Sub_Port_1,Port_Number);
							$fwrite(file_pointer,"Underflow at %h - %h on port:%0d \n",expected_Input1_Add_Sub_Port_1,expected_Input2_Add_Sub_Port_1,Port_Number);
						end
					 if ( port_checker.out_data != expected_Data_Add_Sub_Port_1 )	
						begin
							$display("@%0t Error on response 2 \n",$time);
							$fwrite(file_pointer," Error on response 2 \n");
						end
					
				end	//3	
			end //2
						$display("@%0t invalid response on port %0d\n",$time,Port_Number);	
						$fwrite(file_pointer,"invalid response on port %0d\n",Port_Number);	
	end // port1		  


///////////////***************test port Number 2 ****************////////////	
	if(Port_Number == 2) begin //1
		if( ScoreBoard_ch.q_Tag_add_sub_Port_2.size() > 0) 
			begin  //2
			
				temp_Tag_Add_Sub_Port_2 = ScoreBoard_ch.q_Tag_add_sub_Port_2[$];
			
			if( temp_Tag_Add_Sub_Port_2 == port_checker.out_tag  ) 
				begin //3
					expected_Tag_Add_Sub_Port_2 = ScoreBoard_ch.q_Tag_add_sub_Port_2.pop_back();
					expected_Data_Add_Sub_Port_2 = ScoreBoard_ch.q_GoldenModelResult_add_sub_Port_2.pop_back();
					expected_Command_Add_Sub_Port_2 = ScoreBoard_ch.q_Command_add_sub_Port_2.pop_back();
					expected_Input1_Add_Sub_Port_2 = ScoreBoard_ch.q_Input1_add_sub_Port_2.pop_back();
					expected_Input2_Add_Sub_Port_2 = ScoreBoard_ch.q_Input2_add_sub_Port_2.pop_back();
	
					
					if ( expected_Command_Add_Sub_Port_2 == 1 && expected_Data_Add_Sub_Port_2[32]==1)
						begin
							$display("@%0t Overflow at %h + %h on port:%0d \n",$time,expected_Input1_Add_Sub_Port_2,expected_Input2_Add_Sub_Port_2,Port_Number);
							$fwrite(file_pointer,"Overflow at %h + %h on port:%0d \n",expected_Input1_Add_Sub_Port_2,expected_Input2_Add_Sub_Port_2,Port_Number);
						end
					if (  expected_Command_Add_Sub_Port_2 == 2 && expected_Input1_Add_Sub_Port_2 <											expected_Input2_Add_Sub_Port_2 )
						begin
							$display("@%0t Underflow at %h - %h on port:%0d \n",$time,expected_Input1_Add_Sub_Port_2,expected_Input2_Add_Sub_Port_2,Port_Number);
							$fwrite(file_pointer,"Underflow at %h - %h on port:%0d \n",expected_Input1_Add_Sub_Port_2,expected_Input2_Add_Sub_Port_2,Port_Number);
						end
					 if ( port_checker.out_data != expected_Data_Add_Sub_Port_2 )	
						begin
							$display("@%0t Error on response 2 \n",$time);
							$fwrite(file_pointer," Error on response 2 \n");
						end
					
				end	//3	
			end //2
					 $display("@%0t invalid response on port %0d\n",$time,Port_Number);	
					$fwrite(file_pointer,"invalid response on port %0d\n",Port_Number);		
	end // port2

///////////////***************test port Number 3 ****************////////////	 
	if(Port_Number == 3) begin //1
		if( ScoreBoard_ch.q_Tag_add_sub_Port_3.size() > 0) 
			begin  //2
			
				temp_Tag_Add_Sub_Port_3 = ScoreBoard_ch.q_Tag_add_sub_Port_3[$];
			
			if( temp_Tag_Add_Sub_Port_3 == port_checker.out_tag  ) 
				begin //3
					expected_Tag_Add_Sub_Port_3 = ScoreBoard_ch.q_Tag_add_sub_Port_3.pop_back();
					expected_Data_Add_Sub_Port_3 = ScoreBoard_ch.q_GoldenModelResult_add_sub_Port_3.pop_back();
					expected_Command_Add_Sub_Port_3 = ScoreBoard_ch.q_Command_add_sub_Port_3.pop_back();
					expected_Input1_Add_Sub_Port_3 = ScoreBoard_ch.q_Input1_add_sub_Port_3.pop_back();
					expected_Input2_Add_Sub_Port_3 = ScoreBoard_ch.q_Input2_add_sub_Port_3.pop_back();
		
					
					if ( expected_Command_Add_Sub_Port_3 == 1 && expected_Data_Add_Sub_Port_3[32]==1)
						begin
							$display("@%0t Overflow at %h + %h on port:%0d \n",$time,expected_Input1_Add_Sub_Port_3,expected_Input2_Add_Sub_Port_3,Port_Number);
							$fwrite(file_pointer,"Overflow at %h + %h on port:%0d \n",expected_Input1_Add_Sub_Port_3,expected_Input2_Add_Sub_Port_3,Port_Number);
						end
					if (  expected_Command_Add_Sub_Port_3 == 2 && expected_Input1_Add_Sub_Port_3 <											expected_Input2_Add_Sub_Port_3 )
						begin
							$display("@%0t Underflow at %h - %h on port:%0d \n",$time,expected_Input1_Add_Sub_Port_3,expected_Input2_Add_Sub_Port_3,Port_Number);
							$fwrite(file_pointer,"Underflow at %h - %h on port:%0d \n",expected_Input1_Add_Sub_Port_3,expected_Input2_Add_Sub_Port_3,Port_Number);
						end
					 if ( port_checker.out_data != expected_Data_Add_Sub_Port_3 )	
						begin
							$display("@%0t Error on response 2 \n",$time);
							$fwrite(file_pointer," Error on response 2 \n");
						end
					
				end	//3	
			end //2
						$display("@%0t invalid response on port %0d\n",$time,Port_Number);	
						$fwrite(file_pointer,"invalid response on port %0d\n",Port_Number);	
						
	end // port3
///////////////***************test port Number 4 ****************////////////			
	if(Port_Number == 4) begin //1
		if( ScoreBoard_ch.q_Tag_add_sub_Port_4.size() > 0) 
			begin  //2
			
				temp_Tag_Add_Sub_Port_4 = ScoreBoard_ch.q_Tag_add_sub_Port_4[$];
			
			if( temp_Tag_Add_Sub_Port_4 == port_checker.out_tag  ) 
				begin //3
					expected_Tag_Add_Sub_Port_4 = ScoreBoard_ch.q_Tag_add_sub_Port_4.pop_back();
					expected_Data_Add_Sub_Port_4 = ScoreBoard_ch.q_GoldenModelResult_add_sub_Port_4.pop_back();
					expected_Command_Add_Sub_Port_4 = ScoreBoard_ch.q_Command_add_sub_Port_4.pop_back();
					expected_Input1_Add_Sub_Port_4 = ScoreBoard_ch.q_Input1_add_sub_Port_4.pop_back();
					expected_Input2_Add_Sub_Port_4 = ScoreBoard_ch.q_Input2_add_sub_Port_4.pop_back();
	
					
					if ( expected_Command_Add_Sub_Port_4 == 1 && expected_Data_Add_Sub_Port_4[32]==1)
						begin
							$display("@%0t Overflow at %h + %h on port:%0d \n",$time,expected_Input1_Add_Sub_Port_4,expected_Input2_Add_Sub_Port_4,Port_Number);
							$fwrite(file_pointer,"Overflow at %h + %h on port:%0d \n",expected_Input1_Add_Sub_Port_4,expected_Input2_Add_Sub_Port_4,Port_Number);
						end
					if (  expected_Command_Add_Sub_Port_4 == 2 && expected_Input1_Add_Sub_Port_4 <											expected_Input2_Add_Sub_Port_4 )
						begin
							$display("@%0t Underflow at %h - %h on port:%0d \n",$time,expected_Input1_Add_Sub_Port_4,expected_Input2_Add_Sub_Port_4,Port_Number);
							$fwrite(file_pointer,"Underflow at %h - %h on port:%0d \n",expected_Input1_Add_Sub_Port_4,expected_Input2_Add_Sub_Port_4,Port_Number);
						end
					 if ( port_checker.out_data != expected_Data_Add_Sub_Port_4 )	
						begin
							$display("@%0t Error on response 2 \n",$time);
							$fwrite(file_pointer," Error on response 2 \n");
						end
					
				end	//3	
			end //2
			
			$display("@%0t invalid response on port %0d \n",$time,Port_Number);	
			$fwrite(file_pointer," invalid response on port %0d \n",Port_Number);
	end // port4
////
end // resp2


//////////////////////////////////////////////////////////////
/*if (port_checker.out_response == 2'b11) 
	begin 
		$display ("Internal error or Unused response value");
	end 
*/
///////////////////////////////////////////////////////////////////////

	else if ( port_checker.out_response == 0 &&  port_checker.out_data > 0)
	begin
		$display("@%0t No match data on port: %0d" ,$time,Port_Number);
		$fwrite(file_pointer," No match data on port: %0d\n", Port_Number);
		end
	else if ( port_checker.out_response == 0 &&  port_checker.out_tag > 0)begin
		$display("@%0t No match data on port: %0d" ,$time,Port_Number);
		$fwrite(file_pointer," No match data on port: %0d\n", Port_Number);
	end
	

end //forever
end  //task

endtask

task convert_string(int my_Command);

	case(my_Command)
		4'b0001: cmd_string ="+";
		4'b0010: cmd_string ="-";
		4'b0101: cmd_string ="<<";
		4'b0110: cmd_string =">>";
	endcase

endtask
endclass



`endif