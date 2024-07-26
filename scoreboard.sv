`ifndef scoreboard
`define scoreboard


class scoreboard;

//////////////////////////define queue for Port 1/////////////////
   static bit [0:32] q_GoldenModelResult_add_sub_Port_1[$];  
   static bit [0:1] q_Tag_add_sub_Port_1[$];	
   static bit [0:3] q_Command_add_sub_Port_1[$];   
   static bit [0:31] q_Input1_add_sub_Port_1[$];	
   static bit [0:31] q_Input2_add_sub_Port_1[$]; 

   static bit [0:32] q_GoldenModelResult_shift_Port_1[$];	
   static bit [0:1] q_Tag_shift_Port_1[$];	
   static bit [0:3] q_Command_shift_Port_1[$];  
   static bit [0:31] q_Input1_shift_Port_1[$];  
   static bit [0:31] q_Input2_shift_Port_1[$]; 

   static bit [0:32] q_GoldenModelResult_invalid_Port_1[$];  
   static bit [0:1] q_Tag_invalid_Port_1[$];	
   static bit [0:3] q_Command_invalid_Port_1[$];   
   static bit [0:31] q_Input1_invalid_Port_1[$];	
   static bit [0:31] q_Input2_invalid_Port_1[$];

//////////////////////////define queue for Port 2/////////////////
   static bit [0:32]q_GoldenModelResult_add_sub_Port_2[$];  
  static bit [0:1]q_Tag_add_sub_Port_2[$];	
  static bit [0:3]q_Command_add_sub_Port_2[$];   
  static bit [0:31]q_Input1_add_sub_Port_2[$];	
  static bit [0:31]q_Input2_add_sub_Port_2[$]; 

  static bit [0:32]q_GoldenModelResult_shift_Port_2[$];	
  static bit [0:1]q_Tag_shift_Port_2[$];	
  static bit [0:3]q_Command_shift_Port_2[$];  
  static bit [0:31]q_Input1_shift_Port_2[$];  
  static bit [0:31]q_Input2_shift_Port_2[$]; 

  static bit [0:32]q_GoldenModelResult_invalid_Port_2[$];  
  static bit [0:1]q_Tag_invalid_Port_2[$];	
  static bit [0:3]q_Command_invalid_Port_2[$];   
  static bit [0:31]q_Input1_invalid_Port_2[$];	
  static bit [0:31]q_Input2_invalid_Port_2[$];

//////////////////////////define queue for Port 3/////////////////
  static bit [0:32]q_GoldenModelResult_add_sub_Port_3[$];  
  static bit [0:1]q_Tag_add_sub_Port_3[$];	
  static bit [0:3]q_Command_add_sub_Port_3[$];   
  static bit [0:31]q_Input1_add_sub_Port_3[$];	
  static bit [0:31]q_Input2_add_sub_Port_3[$]; 

  static bit [0:32]q_GoldenModelResult_shift_Port_3[$];	
  static bit [0:1]q_Tag_shift_Port_3[$];	
  static bit [0:3]q_Command_shift_Port_3[$];  
  static bit [0:31]q_Input1_shift_Port_3[$];  
  static bit [0:31]q_Input2_shift_Port_3[$]; 

  static bit [0:32]q_GoldenModelResult_invalid_Port_3[$];  
  static bit [0:1]q_Tag_invalid_Port_3[$];	
  static bit [0:3]q_Command_invalid_Port_3[$];   
  static bit [0:31]q_Input1_invalid_Port_3[$];	
  static bit [0:31]q_Input2_invalid_Port_3[$];

//////////////////////////define queue for Port 4/////////////////
  static bit [0:32]q_GoldenModelResult_add_sub_Port_4[$];  
  static bit [0:1]q_Tag_add_sub_Port_4[$];	
  static bit [0:3]q_Command_add_sub_Port_4[$];   
  static bit [0:31]q_Input1_add_sub_Port_4[$];	
  static bit [0:31]q_Input2_add_sub_Port_4[$]; 

  static bit [0:32]q_GoldenModelResult_shift_Port_4[$];	
  static bit [0:1]q_Tag_shift_Port_4[$];	
  static bit [0:3]q_Command_shift_Port_4[$];  
  static bit [0:31]q_Input1_shift_Port_4[$];  
  static bit [0:31]q_Input2_shift_Port_4[$]; 

  static bit [0:32]q_GoldenModelResult_invalid_Port_4[$];  
  static bit [0:1]q_Tag_invalid_Port_4[$];	
  static bit [0:3]q_Command_invalid_Port_4[$];   
  static bit [0:31]q_Input1_invalid_Port_4[$];	
  static bit [0:31]q_Input2_invalid_Port_4[$];

  

//////////////////declare function for manage tag and free them /////////////////////
	
int counter_tag= -1;   
int wait_for_free_tag=0;

byte gave_tag[$];     //store tags that given to packets
byte q_free_tag_array[$]={};  // store free tags


/**************************give tag****************/ 
/*function [0:1] give_tag ();
	counter_tag = counter_tag +1 ;
	if(counter_tag==0)
	begin
 		gave_tag.push_front(2'b00);
		return 2'b00;
	end
	
	if(counter_tag==1)
	begin
		gave_tag.push_front(2'b01);
		return 2'b01;
	end
	
	if(counter_tag==2)
	begin
		gave_tag.push_front(2'b10);
		return 2'b10;
	end
	
	if(counter_tag==3)
	begin
		gave_tag.push_front(2'b11);
		return 2'b11;
	end
	
	while(counter_tag>=4) begin
		if (q_free_tag_array.size()!=0)
		begin
		wait_for_free_tag=0;
		return q_free_tag_array.pop_front();
		break;
		end

		else
		begin
		//$display("there is not free tag");
		wait_for_free_tag=1;
		end
end	
endfunction*/

/************************ push free tag to queue ********/
/*
function void get_free_tag (input [0:1] my_tag);
		
		//$display("tag is free");
		q_free_tag_array.push_front(my_tag);
		wait_for_free_tag=0;
			
endfunction*/
//////*************************************///////////////////////////

task store_data(
		  bit [0:31] Input1,
		  bit [0:31] Input2,
		  bit [0:1] Tag,
		  bit [0:3] Command,
		  bit [1:4] Port_Number,
		  bit [0:32] Golden_Model_Result
	);
	
	if(Port_Number==1)
	 	begin
		if ( Command == 1 || Command == 2)
		begin
		q_Input1_add_sub_Port_1.push_front(Input1);	
		q_Input2_add_sub_Port_1.push_front(Input2);
		q_Tag_add_sub_Port_1.push_front(Tag);
		q_Command_add_sub_Port_1.push_front(Command);  
		q_GoldenModelResult_add_sub_Port_1.push_front(Golden_Model_Result);  
		//$display(" Port1 Expected Results for Add/Sub queue = %p", q_GoldenModelResult_add_sub_Port_1);
		end
		
		else if  ( Command == 5 || Command == 6)
		begin
		 q_Input1_shift_Port_1.push_front(Input1);	
		 q_Input2_shift_Port_1.push_front(Input2);
		 q_Tag_shift_Port_1.push_front(Tag);	
		 q_Command_shift_Port_1.push_front(Command);   
		 q_GoldenModelResult_shift_Port_1.push_front(Golden_Model_Result);  
		//$display(" Port1 Expected Results Shift queue = %p", q_GoldenModelResult_shift_Port_1);
		end
		
		else
		begin
		q_Input1_invalid_Port_1.push_front(Input1);	
		q_Input2_invalid_Port_1.push_front(Input2); 
		q_Tag_invalid_Port_1.push_front(Tag);	
		q_Command_invalid_Port_1.push_front(Command);   
		q_GoldenModelResult_invalid_Port_1.push_front(Golden_Model_Result); 

		end
		end
		
	if(Port_Number==2)
		begin
		if ( Command == 1 || Command == 2)
		begin
		q_Input1_add_sub_Port_2.push_front(Input1);	
		q_Input2_add_sub_Port_2.push_front(Input2);
		q_Tag_add_sub_Port_2.push_front(Tag);
		q_Command_add_sub_Port_2.push_front(Command);  
		q_GoldenModelResult_add_sub_Port_2.push_front(Golden_Model_Result);  
	
		//$display(" Port2 Expected Results for Add/Sub queue = %p", q_GoldenModelResult_add_sub_Port_2);
		end
		
		else if  ( Command == 5 || Command == 6)
		begin
		 q_Input1_shift_Port_2.push_front(Input1);	
		 q_Input2_shift_Port_2.push_front(Input2);
		 q_Tag_shift_Port_2.push_front(Tag);	
		 q_Command_shift_Port_2.push_front(Command);   
		 q_GoldenModelResult_shift_Port_2.push_front(Golden_Model_Result); 
	
		//$display(" Port2 Expected Results for Shift queue = %p", q_GoldenModelResult_shift_Port_2);
		end
		
		else
		begin
		 q_GoldenModelResult_invalid_Port_2.push_front(Golden_Model_Result);  
		 q_Tag_invalid_Port_2.push_front(Tag);	
		 q_Command_invalid_Port_2.push_front(Command);   
		 q_Input1_invalid_Port_2.push_front(Input1);	
		 q_Input2_invalid_Port_2.push_front(Input2); 

		end
		end
		
	if(Port_Number == 3)	
		begin
		if ( Command == 1 || Command == 2)
		begin
		q_Input1_add_sub_Port_3.push_front(Input1);	
		q_Input2_add_sub_Port_3.push_front(Input2);
		q_Tag_add_sub_Port_3.push_front(Tag);
		q_Command_add_sub_Port_3.push_front(Command);  
		q_GoldenModelResult_add_sub_Port_3.push_front(Golden_Model_Result);  
			
		//$display(" Port3 Expected Results  for Add/Sub queue = %p", q_GoldenModelResult_add_sub_Port_3);
		end
		
		else if  ( Command == 5 || Command == 6)
		begin
		 q_Input1_shift_Port_3.push_front(Input1);	
		 q_Input2_shift_Port_3.push_front(Input2);
		 q_Tag_shift_Port_3.push_front(Tag);	
		 q_Command_shift_Port_3.push_front(Command);   
		 q_GoldenModelResult_shift_Port_3.push_front(Golden_Model_Result);

		//$display(" Port3 Expected Results for Shift queue = %p", q_GoldenModelResult_shift_Port_3);
		end
		
		else
		begin
		 q_GoldenModelResult_invalid_Port_3.push_front(Golden_Model_Result);  
		 q_Tag_invalid_Port_3.push_front(Tag);	
		 q_Command_invalid_Port_3.push_front(Command);   
		 q_Input1_invalid_Port_3.push_front(Input1);	
		 q_Input2_invalid_Port_3.push_front(Input2); 
		end
		end
		
	if( Port_Number==4 )	
		begin
		if ( Command == 1 || Command == 2)
		begin
		q_Input1_add_sub_Port_4.push_front(Input1);	
		q_Input2_add_sub_Port_4.push_front(Input2);
		q_Tag_add_sub_Port_4.push_front(Tag);
		q_Command_add_sub_Port_4.push_front(Command);  
		q_GoldenModelResult_add_sub_Port_4.push_front(Golden_Model_Result); 
			
		//$display(" Port4 Expected Results for Add/Sub queue = %p", q_GoldenModelResult_add_sub_Port_4);
		end
		
		else if  ( Command == 5 || Command == 6)
		begin
		 q_Input1_shift_Port_4.push_front(Input1);	
		 q_Input2_shift_Port_4.push_front(Input2);
		 q_Tag_shift_Port_4.push_front(Tag);	
		 q_Command_shift_Port_4.push_front(Command);   
		 q_GoldenModelResult_shift_Port_4.push_front(Golden_Model_Result); 

		//$display(" Port4 Expected Results for Shift queue = %p", q_GoldenModelResult_shift_Port_4);
		end
		
		else
		begin
		q_GoldenModelResult_invalid_Port_4.push_front(Golden_Model_Result);  
		q_Tag_invalid_Port_4.push_front(Tag);	
		q_Command_invalid_Port_4.push_front(Command);   
		q_Input1_invalid_Port_4.push_front(Input1);	
		q_Input2_invalid_Port_4.push_front(Input2); 
		end
		end
		
endtask

endclass
`endif