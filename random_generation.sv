class random_generation ;


randc bit [0:31] Input1;
randc bit [0:31] Input2;
randc bit [0:1] Tag;
randc bit [0:3] Command;
int flag=0;


task Input_random();
  Input1 = $urandom_range({32{1'b1}},{32{1'b0}});
  Input2 = $urandom_range({32{1'b1}},{32{1'b0}});

endtask

////******************generate Random Command****************************///
task  Command_random() ;
 
  	while(flag==0)
  begin
  Command = $urandom_range(4'b1111,4'b0000);
  if (Command ==4'b0010 || Command ==4'b0001 || Command ==4'b0101 || Command ==4'b0110)
	
	break;
  else
	flag=0;
end
  
endtask


////**********************************************************///

task Tag_random();

  Tag = $urandom_range(2'b11,2'b00);

endtask
 
endclass
