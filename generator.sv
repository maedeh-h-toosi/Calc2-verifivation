`include "interface.sv"
`include "driver.sv"
`include "random_generation.sv"

class Generator;



	virtual Port_Global portGlb;
	virtual Port_Stimuli port1;
	virtual Port_Stimuli port2;
	virtual Port_Stimuli port3;
	virtual Port_Stimuli port4;
	
	Driver Driver_Port_1;
	Driver Driver_Port_2;
	Driver Driver_Port_3;
	Driver Driver_Port_4;
	
	Driver Driver_rand_1 ;
	Driver Driver_rand_2 ;
	Driver Driver_rand_3 ;
	Driver Driver_rand_4 ;


	random_generation Random ; 
	event Finish ;

	time clk_period=100; 

function new (
	virtual Port_Global _portGlb , 
	virtual Port_Stimuli _port1 ,
	virtual Port_Stimuli _port2 , 
	virtual Port_Stimuli _port3 ,
	virtual Port_Stimuli _port4 , 
	event _Finish);

	begin
	this.portGlb = _portGlb;
	this.port1 = _port1;
	this.port2 = _port2;
	this.port3 = _port3;
	this.port4 = _port4;


	this.Finish = _Finish;

	Driver_Port_1 = new(1,portGlb,port1);
	Driver_Port_2 = new(2,portGlb,port2);
	Driver_Port_3 = new(3,portGlb,port3);
	Driver_Port_4 = new(4,portGlb,port4);
	
	Driver_rand_1 = new(1,portGlb,port1);
	Driver_rand_2 = new(2,portGlb,port2);
	Driver_rand_3 = new(3,portGlb,port3);
	Driver_rand_4 = new(4,portGlb,port4);

	
	 Random = new();
	 
	end
endfunction
	
///***************execute all test *************************///	
task Start();
	$write("%t : Generator activated\n" , $time);
	Go_test();
	$write("%t : Generator deactivated\n" , $time);
endtask
	
///*****************Test 4 ports *******************************///	
task Go_test();
	begin
	Reset();
	@(posedge portGlb.c_clk);
		fork
		
		testP1();
		testP2();
		testP3();
		testP4();
		test_random_input();
		testP5();
		 join
		repeat(10)@(posedge portGlb.c_clk);
		->Finish;
	end
endtask

///********************************************************************///	
task test_random_input();

	for (int i=0;i<400 ;i=i+1) begin
	
		Random.Command_random();
		Random.Tag_random();
		Random.Input_random();
	Driver_rand_1.Random_Input(Random.Input1, Random.Input2, Random.Tag , Random.Command);
		#clk_period;

		Random.Command_random();
		Random.Tag_random();
		Random.Input_random();
	Driver_rand_2.Random_Input(Random.Input1, Random.Input2, Random.Tag , Random.Command);
		#clk_period;
	
		Random.Command_random();
		Random.Tag_random();
		Random.Input_random();
	Driver_rand_3.Random_Input(Random.Input1, Random.Input2, Random.Tag , Random.Command);
		#clk_period;
	
		Random.Command_random();
		Random.Tag_random();
		Random.Input_random();
	Driver_rand_4.Random_Input(Random.Input1, Random.Input2, Random.Tag , Random.Command);
		#clk_period;
	
	
	end
	
endtask



task testP5();

	Driver_Port_2.Add({32{1'b1}}, 32'b0000_0100_0000_0000_0000_0001_0000_0000, 0);
	Driver_Port_3.Add({32{1'b0}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_2.Sub({32{1'b1}}, 32'b0000_0000_0000_0111_1000_0001_0001_0001, 2);
	Driver_Port_4.Sub({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0010_0000_0101, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 1);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 0);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;
	
	Driver_Port_1.Add({32{1'b1}}, {32{1'b1}}, 0);
	Driver_Port_3.Add({32{1'b1}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_4.Sub({32{1'b0}}, 32'b0000_0000_0100_0111_1000_0001_0001_0001, 2);
	Driver_Port_2.Sub({32{1'b0}}, {32{1'b1}}, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0000, 2);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1111, 3);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;
	
	Driver_Port_3.Add({32{1'b1}}, {16{1'b1}}, 2);
	Driver_Port_1.Add({32{1'b0}}, {32{1'b1}}, 3);
	Driver_Port_4.Sub({32{1'b0}}, {32{1'b1}}, 0);
	Driver_Port_2.Sub({32{1'b1}}, {32{1'b1}}, 1);
	#clk_period;
	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b1000_0000_0000_0000_0000_0000_0000_0000, 1);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1111, 2);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0100_0010_0001, 0);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1111, 3);
	#clk_period;
	
	Driver_Port_3.Add({32{1'b1}}, {32{1'b1}}, 2);
	Driver_Port_1.Add({32{1'b0}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_4.Sub({32{1'b0}}, 32'b0000_0000_0100_0111_1000_0001_0001_0001, 0);
	Driver_Port_2.Sub({32{1'b1}}, {32{1'b1}}, 3);
	#clk_period;
	
	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_2.Sub({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;


	Driver_Port_2.Add({32{1'b1}}, 32'b0000_0100_0000_0000_0000_0001_0000_0001, 0);
	Driver_Port_3.Add({32{1'b0}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_2.Sub({32{1'b0}}, 32'b0000_0000_0000_0111_1000_0001_0001_0001, 2);
	Driver_Port_2.Sub({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0101, 3);
	#clk_period;	
	Driver_Port_1.Add({32{1'b1}}, 32'b0000_0100_0000_0111_1000_0001_0001_0001, 0);
	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_1010, 2);
	Driver_Port_3.ShiftLeft({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 1);
	Driver_Port_2.Sub({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0101, 3);
	#clk_period;


	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 0);
	Driver_Port_3.ShiftLeft({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 1);
	Driver_Port_4.ShiftRight({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 2);
	Driver_Port_1.ShiftRight({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 3);
	#clk_period;
	Driver_Port_2.Sub({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 0);
	Driver_Port_3.Add({32{1'b1}}, 32'b1111_1111_1111_1111_1111_0000_1111_1110, 1);
	Driver_Port_4.Sub({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 2);
	#clk_period;
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 1);
	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_2.Sub({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;
	
	Driver_Port_2.Add(32'b1000_0000_0000_0000_1111_1111_1111_1111, 32'b0111_1111_1111_1111_0000_0000_0000_0000, 0);
	Driver_Port_3.Sub(32'b1000_0000_0000_0000_1111_1111_1111_1111, 32'b0111_1111_1111_1111_0000_0000_0000_0000, 1);
	Driver_Port_2.Add(32'b1000_0000_0000_0000_1111_1111_1111_1111, 32'b0111_1111_1111_1111_0000_0000_0000_0000, 2);
	Driver_Port_4.Sub(32'b1000_0000_0000_0000_1111_1111_1111_1111, 32'b0111_1111_1111_1111_0000_0000_0000_0000, 3);
	#clk_period;
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 0);
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 1);
	
	#clk_period;
	
	Driver_Port_2.ShiftRight({32{1'b0}}, {32{1'b1}}, 0);
	Driver_Port_3.ShiftRight({32{1'b0}}, {32{1'b1}}, 1);
	Driver_Port_4.ShiftRight({32{1'b0}}, {32{1'b1}}, 2);
	Driver_Port_2.ShiftRight({32{1'b0}}, {32{1'b1}}, 3);
	#clk_period;
	
	Driver_Port_2.Add({32{1'b1}}, 32'b0000_0100_0000_0000_0000_0001_0000_0000, 0);
	Driver_Port_3.Add({32{1'b0}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_2.Sub({32{1'b1}}, 32'b0000_0000_0000_0111_1000_0001_0001_0001, 2);
	Driver_Port_4.Sub({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0010_0000_0101, 3);
	#clk_period;
	
	Driver_Port_3.Add({32{1'b1}}, {16{1'b1}}, 2);
	Driver_Port_1.Add({32{1'b0}}, {32{1'b1}}, 3);
	Driver_Port_4.Sub({32{1'b0}}, {32{1'b1}}, 0);
	Driver_Port_2.Sub({32{1'b1}}, {32{1'b1}}, 1);
	#clk_period;
	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b1000_0000_0000_0000_0000_0000_0000_0000, 1);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1111, 2);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0100_0010_0001, 0);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1111, 3);
	#clk_period;
	
	Driver_Port_3.Add({32{1'b1}}, {32{1'b1}}, 2);
	Driver_Port_1.Add({32{1'b0}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_4.Sub({32{1'b0}}, 32'b0000_0000_0100_0111_1000_0001_0001_0001, 0);
	Driver_Port_2.Sub({32{1'b1}}, {32{1'b1}}, 3);
	#clk_period;
	
	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_2.Sub({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;

	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 1);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 0);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;
	
	Driver_Port_1.Add({32{1'b1}}, {32{1'b1}}, 0);
	Driver_Port_3.Add({32{1'b1}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_4.Sub({32{1'b0}}, 32'b0000_0000_0100_0111_1000_0001_0001_0001, 2);
	Driver_Port_2.Sub({32{1'b0}}, {32{1'b1}}, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0000, 2);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1111, 3);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;
	
	Driver_Port_3.Add({32{1'b1}}, {16{1'b1}}, 2);
	Driver_Port_1.Add({32{1'b0}}, {32{1'b1}}, 3);
	Driver_Port_4.Sub({32{1'b0}}, {32{1'b1}}, 0);
	Driver_Port_2.Sub({32{1'b1}}, {32{1'b1}}, 1);
	#clk_period;
	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b1000_0000_0000_0000_0000_0000_0000_0000, 1);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1111, 2);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0100_0010_0001, 0);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1111, 3);
	#clk_period;
	
	Driver_Port_3.Add({32{1'b1}}, {32{1'b1}}, 2);
	Driver_Port_1.Add({32{1'b0}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_4.Sub({32{1'b0}}, 32'b0000_0000_0100_0111_1000_0001_0001_0001, 0);
	Driver_Port_2.Sub({32{1'b1}}, {32{1'b1}}, 3);
	#clk_period;
	
	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_2.Sub({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;


	Driver_Port_2.Add({32{1'b1}}, 32'b0000_0100_0000_0000_0000_0001_0000_0001, 0);
	Driver_Port_3.Add({32{1'b0}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_2.Sub({32{1'b0}}, 32'b0000_0000_0000_0111_1000_0001_0001_0001, 2);
	Driver_Port_2.Sub({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0101, 3);
	#clk_period;	
	Driver_Port_1.Add({32{1'b1}}, 32'b0000_0100_0000_0111_1000_0001_0001_0001, 0);
	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_1010, 2);
	Driver_Port_3.ShiftLeft({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 1);
	Driver_Port_2.Sub({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0101, 3);
	#clk_period;


	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 0);
	Driver_Port_3.ShiftLeft({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 1);
	Driver_Port_4.ShiftRight({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 2);
	Driver_Port_1.ShiftRight({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 3);
	#clk_period;

	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_2.Sub({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;


	Driver_Port_2.Add({32{1'b1}}, 32'b0000_0100_0000_0000_0000_0001_0000_0001, 0);
	Driver_Port_3.Add({32{1'b0}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_2.Sub({32{1'b0}}, 32'b0000_0000_0000_0111_1000_0001_0001_0001, 2);
	Driver_Port_2.Sub({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0101, 3);
	#clk_period;	
	Driver_Port_1.Add({32{1'b1}}, 32'b0000_0100_0000_0111_1000_0001_0001_0001, 0);
	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_1010, 2);
	Driver_Port_3.ShiftLeft({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 1);
	Driver_Port_2.Sub({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0101, 3);
	#clk_period;

	Driver_Port_2.Add({32{1'b1}}, 32'b0000_0100_0000_0000_0000_0001_0000_0000, 0);
	Driver_Port_3.Add({32{1'b0}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_2.Sub({32{1'b1}}, 32'b0000_0000_0000_0111_1000_0001_0001_0001, 2);
	Driver_Port_4.Sub({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0010_0000_0101, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 1);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 0);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;
	
	Driver_Port_1.Add({32{1'b1}}, {32{1'b1}}, 0);
	Driver_Port_3.Add({32{1'b1}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_4.Sub({32{1'b0}}, 32'b0000_0000_0100_0111_1000_0001_0001_0001, 2);
	Driver_Port_2.Sub({32{1'b0}}, {32{1'b1}}, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0000, 2);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1111, 3);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;
	
	Driver_Port_3.Add({32{1'b1}}, {16{1'b1}}, 2);
	Driver_Port_1.Add({32{1'b0}}, {32{1'b1}}, 3);
	Driver_Port_4.Sub({32{1'b0}}, {32{1'b1}}, 0);
	Driver_Port_2.Sub({32{1'b1}}, {32{1'b1}}, 1);
	#clk_period;
	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b1000_0000_0000_0000_0000_0000_0000_0000, 1);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1111, 2);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0100_0010_0001, 0);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1111, 3);
	#clk_period;
	
	Driver_Port_3.Add({32{1'b1}}, {32{1'b1}}, 2);
	Driver_Port_1.Add({32{1'b0}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_4.Sub({32{1'b0}}, 32'b0000_0000_0100_0111_1000_0001_0001_0001, 0);
	Driver_Port_2.Sub({32{1'b1}}, {32{1'b1}}, 3);
	#clk_period;
	
	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_2.Sub({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;


	Driver_Port_2.Add({32{1'b1}}, 32'b0000_0100_0000_0000_0000_0001_0000_0001, 0);
	Driver_Port_3.Add({32{1'b0}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_2.Sub({32{1'b0}}, 32'b0000_0000_0000_0111_1000_0001_0001_0001, 2);
	Driver_Port_2.Sub({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0101, 3);
	#clk_period;	
	Driver_Port_1.Add({32{1'b1}}, 32'b0000_0100_0000_0111_1000_0001_0001_0001, 0);
	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_1010, 2);
	Driver_Port_3.ShiftLeft({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 1);
	Driver_Port_2.Sub({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0101, 3);
	#clk_period;


	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 0);
	Driver_Port_3.ShiftLeft({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 1);
	Driver_Port_4.ShiftRight({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 2);
	Driver_Port_1.ShiftRight({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 3);
	#clk_period;
	Driver_Port_2.Sub({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 0);
	Driver_Port_3.Add({32{1'b1}}, 32'b1111_1111_1111_1111_1111_0000_1111_1110, 1);
	Driver_Port_4.Sub({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 2);
	#clk_period;
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 1);
	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_2.Sub({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;
	
	Driver_Port_2.Add(32'b1000_0000_0000_0000_1111_1111_1111_1111, 32'b0111_1111_1111_1111_0000_0000_0000_0000, 0);
	Driver_Port_3.Sub(32'b1000_0000_0000_0000_1111_1111_1111_1111, 32'b0111_1111_1111_1111_0000_0000_0000_0000, 1);
	Driver_Port_2.Add(32'b1000_0000_0000_0000_1111_1111_1111_1111, 32'b0111_1111_1111_1111_0000_0000_0000_0000, 2);
	Driver_Port_4.Sub(32'b1000_0000_0000_0000_1111_1111_1111_1111, 32'b0111_1111_1111_1111_0000_0000_0000_0000, 3);
	#clk_period;
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 0);
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 1);
	
	#clk_period;
	
	Driver_Port_2.ShiftRight({32{1'b0}}, {32{1'b1}}, 0);
	Driver_Port_3.ShiftRight({32{1'b0}}, {32{1'b1}}, 1);
	Driver_Port_4.ShiftRight({32{1'b0}}, {32{1'b1}}, 2);
	Driver_Port_2.ShiftRight({32{1'b0}}, {32{1'b1}}, 3);
	#clk_period;
	
	Driver_Port_2.Add({32{1'b1}}, 32'b0000_0100_0000_0000_0000_0001_0000_0000, 0);
	Driver_Port_3.Add({32{1'b0}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_2.Sub({32{1'b1}}, 32'b0000_0000_0000_0111_1000_0001_0001_0001, 2);
	Driver_Port_4.Sub({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0010_0000_0101, 3);
	#clk_period;
	
		Driver_Port_3.Add({32{1'b1}}, {16{1'b1}}, 2);
	Driver_Port_1.Add({32{1'b0}}, {32{1'b1}}, 3);
	Driver_Port_4.Sub({32{1'b0}}, {32{1'b1}}, 0);
	Driver_Port_2.Sub({32{1'b1}}, {32{1'b1}}, 1);
	#clk_period;
	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b1000_0000_0000_0000_0000_0000_0000_0000, 1);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1111, 2);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0100_0010_0001, 0);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1111, 3);
	#clk_period;
	
	Driver_Port_3.Add({32{1'b1}}, {32{1'b1}}, 2);
	Driver_Port_1.Add({32{1'b0}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_4.Sub({32{1'b0}}, 32'b0000_0000_0100_0111_1000_0001_0001_0001, 0);
	Driver_Port_2.Sub({32{1'b1}}, {32{1'b1}}, 3);
	#clk_period;
	
	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_2.Sub({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;

	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 1);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 0);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;
	
	Driver_Port_1.Add({32{1'b1}}, {32{1'b1}}, 0);
	Driver_Port_3.Add({32{1'b1}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_4.Sub({32{1'b0}}, 32'b0000_0000_0100_0111_1000_0001_0001_0001, 2);
	Driver_Port_2.Sub({32{1'b0}}, {32{1'b1}}, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0000, 2);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1111, 3);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;
	
	Driver_Port_3.Add({32{1'b1}}, {16{1'b1}}, 2);
	Driver_Port_1.Add({32{1'b0}}, {32{1'b1}}, 3);
	Driver_Port_4.Sub({32{1'b0}}, {32{1'b1}}, 0);
	Driver_Port_2.Sub({32{1'b1}}, {32{1'b1}}, 1);
	#clk_period;
	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b1000_0000_0000_0000_0000_0000_0000_0000, 1);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1111, 2);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0100_0010_0001, 0);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1111, 3);
	#clk_period;
	
	Driver_Port_3.Add({32{1'b1}}, {32{1'b1}}, 2);
	Driver_Port_1.Add({32{1'b0}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_4.Sub({32{1'b0}}, 32'b0000_0000_0100_0111_1000_0001_0001_0001, 0);
	Driver_Port_2.Sub({32{1'b1}}, {32{1'b1}}, 3);
	#clk_period;
	
	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_2.Sub({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_2.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_4.ShiftLeft({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;


	Driver_Port_2.Add({32{1'b1}}, 32'b0000_0100_0000_0000_0000_0001_0000_0001, 0);
	Driver_Port_3.Add({32{1'b0}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_2.Sub({32{1'b0}}, 32'b0000_0000_0000_0111_1000_0001_0001_0001, 2);
	Driver_Port_2.Sub({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0101, 3);
	#clk_period;	
	Driver_Port_1.Add({32{1'b1}}, 32'b0000_0100_0000_0111_1000_0001_0001_0001, 0);
	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_1010, 2);
	Driver_Port_3.ShiftLeft({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 1);
	Driver_Port_2.Sub({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0101, 3);
	#clk_period;


	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 0);
	Driver_Port_3.ShiftLeft({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 1);
	Driver_Port_4.ShiftRight({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 2);
	Driver_Port_1.ShiftRight({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 3);
	#clk_period;

	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0001, 2);
	Driver_Port_3.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0010_0001, 3);
	Driver_Port_2.Sub({32{1'b1}}, 32'b1111_1111_1111_1111_1111_1111_1111_1110, 3);
	#clk_period;


	Driver_Port_2.Add({32{1'b1}}, 32'b0000_0100_0000_0000_0000_0001_0000_0001, 0);
	Driver_Port_3.Add({32{1'b0}}, 32'b0000_0000_0110_0000_0000_0000_0000_0101, 1);
	Driver_Port_2.Sub({32{1'b0}}, 32'b0000_0000_0000_0111_1000_0001_0001_0001, 2);
	Driver_Port_2.Sub({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_0101, 3);
	#clk_period;	
	Driver_Port_1.Add({32{1'b1}}, 32'b0000_0100_0000_0111_1000_0001_0001_0001, 0);
	Driver_Port_2.ShiftRight({32{1'b0}}, 32'b0000_0000_0000_0000_0000_0000_0000_1010, 2);
	Driver_Port_3.ShiftLeft({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0010, 1);
	Driver_Port_2.Sub({32{1'b1}}, 32'b0000_0000_0000_0000_0000_0000_0000_0101, 3);
	#clk_period;
	

	

endtask

///********************************************************************///
task testP1();
	begin

	Driver_Port_1.Add(32'h00000000, 32'h00000000, 0);
	Driver_Port_1.Add(32'h00000000, 32'h00000000, 1);
	Driver_Port_1.Add(32'h00000000, 32'h00000000, 2);
	Driver_Port_1.Add(32'h00000000, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_1.Add(32'h00501401, 32'h00000215, 0);
	Driver_Port_1.Add(32'h00501402, 32'h00000215, 1);
	Driver_Port_1.Add(32'h00501403, 32'h00000215, 2);
	Driver_Port_1.Add(32'h00501404, 32'h00000215, 3);
	#clk_period;
	
	Driver_Port_1.Add(32'h00000000, 32'h00004000, 0);
	Driver_Port_1.Add(32'h00000000, 32'h00000500, 1);
	Driver_Port_1.Add(32'h00000000, 32'h00030000, 2);
	Driver_Port_1.Add(32'h00000000, 32'h00008000, 3);
	#clk_period;
	
	Driver_Port_1.Add(32'hffffffff, 32'h00000000, 0);
	Driver_Port_1.Add(32'hffffffff, 32'h00000000, 1);
	Driver_Port_1.Add(32'hffffffff, 32'h00000000, 2);
	Driver_Port_1.Add(32'hffffffff, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_1.Add(32'hffffffff, 32'h00000001, 0);
	Driver_Port_1.Add(32'hffffffff, 32'h00000001, 1);
	Driver_Port_1.Add(32'hffffffff, 32'h00000001, 2);
	Driver_Port_1.Add(32'hffffffff, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_1.Add(32'hfffffffe, 32'h00000002, 0);
	Driver_Port_1.Add(32'hfffffffe, 32'h00000002, 1);
	Driver_Port_1.Add(32'hfffffffe, 32'h00000002, 2);
	Driver_Port_1.Add(32'hfffffffe, 32'h00000002, 3);
	#clk_period;
	
	Driver_Port_1.Add(32'hfffffffd, 32'h00000003, 0);
	Driver_Port_1.Add(32'hfffffffd, 32'h00000003, 1);
	Driver_Port_1.Add(32'hfffffffd, 32'h00000003, 2);
	Driver_Port_1.Add(32'hfffffffd, 32'h00000003, 3);
	#clk_period;
	
	Driver_Port_1.Add(32'h0000ffff, 32'hffff0000, 0);
	Driver_Port_1.Add(32'h0000ffff, 32'hffff0000, 1);
	Driver_Port_1.Add(32'h0000ffff, 32'hffff0000, 2);
	Driver_Port_1.Add(32'h0000ffff, 32'hffff0000, 3);
	#clk_period;
	
	Driver_Port_1.Add(32'h1000ffff, 32'hffff0000, 0);
	Driver_Port_1.Add(32'h1000ffff, 32'hffff0000, 1);
	Driver_Port_1.Add(32'h1000ffff, 32'hffff0000, 2);
	Driver_Port_1.Add(32'h1000ffff, 32'hffff0000, 3);
	#clk_period;
	
	Driver_Port_1.Add(32'h0000ffff, 32'hffff0001, 0);
	Driver_Port_1.Add(32'h0000ffff, 32'hffff0001, 1);
	Driver_Port_1.Add(32'h0000ffff, 32'hffff0001, 2);
	Driver_Port_1.Add(32'h0000ffff, 32'hffff0001, 3);
	#clk_period;
	
	Driver_Port_1.Add(32'h0000ffff, 32'hfffe0000, 0);
	Driver_Port_1.Add(32'h0000ffff, 32'hffff0e00, 1);
	Driver_Port_1.Add(32'h0000ffff, 32'hffffe000, 2);
	Driver_Port_1.Add(32'h0000ffff, 32'hffff00e0, 3);
	#clk_period;
	
	Driver_Port_1.Add(32'h0000ffff, 32'h0000ffff, 0);
	Driver_Port_1.Add(32'h0000ffff, 32'h0000ffff, 1);
	Driver_Port_1.Add(32'h0000ffff, 32'h0000ffff, 2);
	Driver_Port_1.Add(32'h0000ffff, 32'h0000ffff, 3);
	#clk_period;
	
	
	Driver_Port_1.Sub(32'h00000000, 32'h00000000, 0);
	Driver_Port_1.Sub(32'h00000000, 32'h00000000, 1);
	Driver_Port_1.Sub(32'h00000000, 32'h00000000, 2);
	Driver_Port_1.Sub(32'h00000000, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_1.Sub(32'h00000000, 32'h00000001, 0);
	Driver_Port_1.Sub(32'h00000000, 32'h00000001, 1);
	Driver_Port_1.Sub(32'h00000000, 32'h00000001, 2);
	Driver_Port_1.Sub(32'h00000000, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_1.Sub(32'h00003450, 32'h00000031, 0);
	Driver_Port_1.Sub(32'h00022000, 32'h00000011, 1);
	Driver_Port_1.Sub(32'h00000341, 32'h00000301, 2);
	Driver_Port_1.Sub(32'h00000020, 32'h00000005, 3);
	#clk_period;
	
	Driver_Port_1.Sub(32'h00003450, 32'h00030031, 0);
	Driver_Port_1.Sub(32'h00022000, 32'h00300011, 1);
	Driver_Port_1.Sub(32'h00000341, 32'h00003301, 2);
	Driver_Port_1.Sub(32'h00000020, 32'h00003005, 3);
	#clk_period;
	
	Driver_Port_1.Sub(32'h0000ffff, 32'h0000ffff, 0);
	Driver_Port_1.Sub(32'h0000ffff, 32'h0000ffff, 1);
	Driver_Port_1.Sub(32'h0000ffff, 32'h0000ffff, 2);
	Driver_Port_1.Sub(32'h0000ffff, 32'h0000ffff, 3);
	#clk_period;
	
	Driver_Port_1.Sub(32'h0000ffff, 32'h000fffff, 0);
	Driver_Port_1.Sub(32'h0000ffff, 32'h000fffff, 1);
	Driver_Port_1.Sub(32'h0000ffff, 32'h000fffff, 2);
	Driver_Port_1.Sub(32'h0000ffff, 32'h000fffff, 3);
	#clk_period;
	
	Driver_Port_1.Sub(32'h00000000, 32'hffffffff, 0);
	Driver_Port_1.Sub(32'h00000000, 32'hffffffff, 1);
	Driver_Port_1.Sub(32'h00000000, 32'hffffffff, 2);
	Driver_Port_1.Sub(32'h00000000, 32'hffffffff, 3);
	#clk_period;
	
	Driver_Port_1.Sub(32'h0000000e, 32'h0000000f, 0);
	Driver_Port_1.Sub(32'h0000000e, 32'h0000000f, 1);
	Driver_Port_1.Sub(32'h0000000e, 32'h0000000f, 2);
	Driver_Port_1.Sub(32'h0000000e, 32'h0000000f, 3);
	#clk_period;
	
	Driver_Port_1.Sub(32'h00000002, 32'h00000002, 0);
	Driver_Port_1.Sub(32'h00000002, 32'h00000002, 1);
	Driver_Port_1.Sub(32'h00000002, 32'h00000002, 2);
	Driver_Port_1.Sub(32'h00000002, 32'h00000002, 3);
	#clk_period;
	
	Driver_Port_1.Sub(32'h00000002, 32'h00000003, 0);
	Driver_Port_1.Sub(32'h00000002, 32'h00000003, 1);
	Driver_Port_1.Sub(32'h00000002, 32'h00000003, 2);
	Driver_Port_1.Sub(32'h00000002, 32'h00000003, 3);
	#clk_period;
	
	Driver_Port_1.Sub(32'hffffffff, 32'hffffffff, 0);
	Driver_Port_1.Sub(32'hffffffff, 32'hffffffff, 1);
	Driver_Port_1.Sub(32'hffffffff, 32'hffffffff, 2);
	Driver_Port_1.Sub(32'hffffffff, 32'hffffffff, 3);
	#clk_period;
	
	Driver_Port_1.Sub(32'hffffffff, 32'h00000000, 0);
	Driver_Port_1.Sub(32'hffffffff, 32'h00000000, 1);
	Driver_Port_1.Sub(32'hffffffff, 32'h00000000, 2);
	Driver_Port_1.Sub(32'hffffffff, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_1.Sub(32'hefffffff, 32'hffffffff, 0);
	Driver_Port_1.Sub(32'hefffffff, 32'hffffffff, 1);
	Driver_Port_1.Sub(32'hefffffff, 32'hffffffff, 2);
	Driver_Port_1.Sub(32'hefffffff, 32'hffffffff, 3);
	
	
	
	
	Driver_Port_1.ShiftLeft(32'h00000000, 32'h00000000, 0);
	Driver_Port_1.ShiftLeft(32'h00000000, 32'h00000000, 1);
	Driver_Port_1.ShiftLeft(32'h00000000, 32'h00000000, 2);
	Driver_Port_1.ShiftLeft(32'h00000000, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_1.ShiftLeft(32'h00000000, 32'h00000001, 0);
	Driver_Port_1.ShiftLeft(32'h00000000, 32'h00000001, 1);
	Driver_Port_1.ShiftLeft(32'h00000000, 32'h00000001, 2);
	Driver_Port_1.ShiftLeft(32'h00000000, 32'h00000001, 3);	
	#clk_period;
	
	Driver_Port_1.ShiftLeft(32'h00000000, 32'h00000010, 0);
	Driver_Port_1.ShiftLeft(32'h00000000, 32'h00000010, 1);
	Driver_Port_1.ShiftLeft(32'h00000000, 32'h00000010, 2);
	Driver_Port_1.ShiftLeft(32'h00000000, 32'h00000010, 3);	
	#clk_period;
	
	Driver_Port_1.ShiftLeft(32'hffffffff, 32'h00000000, 0);
	Driver_Port_1.ShiftLeft(32'hffffffff, 32'h00000000, 1);
	Driver_Port_1.ShiftLeft(32'hffffffff, 32'h00000000, 2);
	Driver_Port_1.ShiftLeft(32'hffffffff, 32'h00000000, 3);
	#clk_period;
		
	Driver_Port_1.ShiftLeft(32'hffffffff, 32'h00000001, 0);
	Driver_Port_1.ShiftLeft(32'hffffffff, 32'h00000001, 1);
	Driver_Port_1.ShiftLeft(32'hffffffff, 32'h00000001, 2);
	Driver_Port_1.ShiftLeft(32'hffffffff, 32'h00000001, 3);	
	#clk_period;
	
	Driver_Port_1.ShiftLeft(32'h0fffffff, 32'h0000000f, 0);
	Driver_Port_1.ShiftLeft(32'h0fffffff, 32'h0000000f, 1);
	Driver_Port_1.ShiftLeft(32'h0fffffff, 32'h0000000f, 2);
	Driver_Port_1.ShiftLeft(32'h0fffffff, 32'h0000000f, 3);
	#clk_period;
	
	Driver_Port_1.ShiftLeft(32'h00045200, 32'h00000fff, 0);
	Driver_Port_1.ShiftLeft(32'h00004200, 32'h00000fff, 1);
	Driver_Port_1.ShiftLeft(32'h0004f000, 32'h00000fff, 2);
	Driver_Port_1.ShiftLeft(32'h00000460, 32'h00000fff, 3);
	#clk_period;
	
	Driver_Port_1.ShiftLeft(32'h0fffffff, 32'h00000001, 0);
	Driver_Port_1.ShiftLeft(32'h0fffffff, 32'h00000001, 1);
	Driver_Port_1.ShiftLeft(32'h0fffffff, 32'h00000001, 2);
	Driver_Port_1.ShiftLeft(32'h0fffffff, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_1.ShiftLeft(32'hf0000000, 32'h00000100, 0);
	Driver_Port_1.ShiftLeft(32'hf0000000, 32'h00000100, 1);
	Driver_Port_1.ShiftLeft(32'hf0000000, 32'h00000100, 2);
	Driver_Port_1.ShiftLeft(32'hf0000000, 32'h00000100, 3);
	#clk_period;
	
	Driver_Port_1.ShiftLeft(32'hff000000, 32'h00001000, 0);
	Driver_Port_1.ShiftLeft(32'hff000000, 32'h00001000, 1);
	Driver_Port_1.ShiftLeft(32'hff000000, 32'h00001000, 2);
	Driver_Port_1.ShiftLeft(32'hff000000, 32'h00001000, 3);
	#clk_period;
	
	
	Driver_Port_1.ShiftRight(32'h0000000e, 32'h00000002, 0);
	Driver_Port_1.ShiftRight(32'h0000000e, 32'h00000002, 1);
	Driver_Port_1.ShiftRight(32'h0000000e, 32'h00000002, 2);
	Driver_Port_1.ShiftRight(32'h0000000e, 32'h00000002, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight(32'h0000000e, 32'h00000004, 0);
	Driver_Port_1.ShiftRight(32'h0000000e, 32'h00000004, 1);
	Driver_Port_1.ShiftRight(32'h0000000e, 32'h00000004, 2);
	Driver_Port_1.ShiftRight(32'h0000000e, 32'h00000004, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight(32'h00000000, 32'h00000000, 0);
	Driver_Port_1.ShiftRight(32'h00000000, 32'h00000000, 1);
	Driver_Port_1.ShiftRight(32'h00000000, 32'h00000000, 2);
	Driver_Port_1.ShiftRight(32'h00000000, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight(32'hffffffff, 32'h00000000, 0);
	Driver_Port_1.ShiftRight(32'hffffffff, 32'h00000000, 1);
	Driver_Port_1.ShiftRight(32'hffffffff, 32'h00000000, 2);
	Driver_Port_1.ShiftRight(32'hffffffff, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight(32'hffffffff, 32'hffffffff, 0);
	Driver_Port_1.ShiftRight(32'hffffffff, 32'hffffffff, 1);
	Driver_Port_1.ShiftRight(32'hffffffff, 32'hffffffff, 2);
	Driver_Port_1.ShiftRight(32'hffffffff, 32'hffffffff, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight(32'h00000000, 32'h00000001, 0);
	Driver_Port_1.ShiftRight(32'h00000000, 32'h00000001, 1);
	Driver_Port_1.ShiftRight(32'h00000000, 32'h00000001, 2);
	Driver_Port_1.ShiftRight(32'h00000000, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight(32'h00fff000, 32'h00001100, 0);
	Driver_Port_1.ShiftRight(32'h00fff000, 32'h00001100, 1);
	Driver_Port_1.ShiftRight(32'h00fff000, 32'h00001100, 2);
	Driver_Port_1.ShiftRight(32'h00fff000, 32'h00001100, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight(32'h00fff000, 32'h00001110, 0);
	Driver_Port_1.ShiftRight(32'h00fff000, 32'h00001110, 1);
	Driver_Port_1.ShiftRight(32'h00fff000, 32'h00001110, 2);
	Driver_Port_1.ShiftRight(32'h00fff000, 32'h00001110, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight(32'hfffffffe, 32'h00000000, 0);
	Driver_Port_1.ShiftRight(32'hfffffffe, 32'h00000000, 1);
	Driver_Port_1.ShiftRight(32'hfffffffe, 32'h00000000, 2);
	Driver_Port_1.ShiftRight(32'hfffffffe, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight(32'h00000001, 32'h00000001, 0);
	Driver_Port_1.ShiftRight(32'h00000001, 32'h00000001, 1);
	Driver_Port_1.ShiftRight(32'h00000001, 32'h00000001, 2);
	Driver_Port_1.ShiftRight(32'h00000001, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight(32'h0000000f, 32'h00000100, 0);
	Driver_Port_1.ShiftRight(32'h0000000f, 32'h00000100, 1);
	Driver_Port_1.ShiftRight(32'h0000000f, 32'h00000100, 2);
	Driver_Port_1.ShiftRight(32'h0000000f, 32'h00000100, 3);
	#clk_period;
	
	Driver_Port_1.ShiftRight(32'h00000fff, 32'h00001100, 0);
	Driver_Port_1.ShiftRight(32'h00000fff, 32'h00001100, 1);
	Driver_Port_1.ShiftRight(32'h00000fff, 32'h00001100, 2);
	Driver_Port_1.ShiftRight(32'h00000fff, 32'h00001100, 3);
	#clk_period;

	

		
	end
endtask 
///********************************************************************///
	task testP2();
	
	begin
		Driver_Port_2.Add(32'h00000000, 32'h00000000, 0);
	Driver_Port_2.Add(32'h00000000, 32'h00000000, 1);
	Driver_Port_2.Add(32'h00000000, 32'h00000000, 2);
	Driver_Port_2.Add(32'h00000000, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_2.Add(32'h00501401, 32'h00000215, 0);
	Driver_Port_2.Add(32'h00501402, 32'h00000215, 1);
	Driver_Port_2.Add(32'h00501403, 32'h00000215, 2);
	Driver_Port_2.Add(32'h00501404, 32'h00000215, 3);
	#clk_period;
	
	Driver_Port_2.Add(32'h00000000, 32'h00004000, 0);
	Driver_Port_2.Add(32'h00000000, 32'h00000500, 1);
	Driver_Port_2.Add(32'h00000000, 32'h00030000, 2);
	Driver_Port_2.Add(32'h00000000, 32'h00008000, 3);
	#clk_period;
	
	Driver_Port_2.Add(32'hffffffff, 32'h00000000, 0);
	Driver_Port_2.Add(32'hffffffff, 32'h00000000, 1);
	Driver_Port_2.Add(32'hffffffff, 32'h00000000, 2);
	Driver_Port_2.Add(32'hffffffff, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_2.Add(32'hffffffff, 32'h00000001, 0);
	Driver_Port_2.Add(32'hffffffff, 32'h00000001, 1);
	Driver_Port_2.Add(32'hffffffff, 32'h00000001, 2);
	Driver_Port_2.Add(32'hffffffff, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_2.Add(32'hfffffffe, 32'h00000002, 0);
	Driver_Port_2.Add(32'hfffffffe, 32'h00000002, 1);
	Driver_Port_2.Add(32'hfffffffe, 32'h00000002, 2);
	Driver_Port_2.Add(32'hfffffffe, 32'h00000002, 3);
	#clk_period;
	
	Driver_Port_2.Add(32'hfffffffd, 32'h00000003, 0);
	Driver_Port_2.Add(32'hfffffffd, 32'h00000003, 1);
	Driver_Port_2.Add(32'hfffffffd, 32'h00000003, 2);
	Driver_Port_2.Add(32'hfffffffd, 32'h00000003, 3);
	#clk_period;
	
	Driver_Port_2.Add(32'h0000ffff, 32'hffff0000, 0);
	Driver_Port_2.Add(32'h0000ffff, 32'hffff0000, 1);
	Driver_Port_2.Add(32'h0000ffff, 32'hffff0000, 2);
	Driver_Port_2.Add(32'h0000ffff, 32'hffff0000, 3);
	#clk_period;
	
	Driver_Port_2.Add(32'h1000ffff, 32'hffff0000, 0);
	Driver_Port_2.Add(32'h1000ffff, 32'hffff0000, 1);
	Driver_Port_2.Add(32'h1000ffff, 32'hffff0000, 2);
	Driver_Port_2.Add(32'h1000ffff, 32'hffff0000, 3);
	#clk_period;
	
	Driver_Port_2.Add(32'h0000ffff, 32'hffff0001, 0);
	Driver_Port_2.Add(32'h0000ffff, 32'hffff0001, 1);
	Driver_Port_2.Add(32'h0000ffff, 32'hffff0001, 2);
	Driver_Port_2.Add(32'h0000ffff, 32'hffff0001, 3);
	#clk_period;
	
	Driver_Port_2.Add(32'h0000ffff, 32'hfffe0000, 0);
	Driver_Port_2.Add(32'h0000ffff, 32'hffff0e00, 1);
	Driver_Port_2.Add(32'h0000ffff, 32'hffffe000, 2);
	Driver_Port_2.Add(32'h0000ffff, 32'hffff00e0, 3);
	#clk_period;
	
	Driver_Port_2.Add(32'h0000ffff, 32'h0000ffff, 0);
	Driver_Port_2.Add(32'h0000ffff, 32'h0000ffff, 1);
	Driver_Port_2.Add(32'h0000ffff, 32'h0000ffff, 2);
	Driver_Port_2.Add(32'h0000ffff, 32'h0000ffff, 3);
	#clk_period;
	
	
	Driver_Port_2.Sub(32'h00000000, 32'h00000000, 0);
	Driver_Port_2.Sub(32'h00000000, 32'h00000000, 1);
	Driver_Port_2.Sub(32'h00000000, 32'h00000000, 2);
	Driver_Port_2.Sub(32'h00000000, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_2.Sub(32'h00000000, 32'h00000001, 0);
	Driver_Port_2.Sub(32'h00000000, 32'h00000001, 1);
	Driver_Port_2.Sub(32'h00000000, 32'h00000001, 2);
	Driver_Port_2.Sub(32'h00000000, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_2.Sub(32'h00003450, 32'h00000031, 0);
	Driver_Port_2.Sub(32'h00022000, 32'h00000011, 1);
	Driver_Port_2.Sub(32'h00000341, 32'h00000301, 2);
	Driver_Port_2.Sub(32'h00000020, 32'h00000005, 3);
	#clk_period;
	
	Driver_Port_2.Sub(32'h00003450, 32'h00030031, 0);
	Driver_Port_2.Sub(32'h00022000, 32'h00300011, 1);
	Driver_Port_2.Sub(32'h00000341, 32'h00003301, 2);
	Driver_Port_2.Sub(32'h00000020, 32'h00003005, 3);
	#clk_period;
	
	Driver_Port_2.Sub(32'h0000ffff, 32'h0000ffff, 0);
	Driver_Port_2.Sub(32'h0000ffff, 32'h0000ffff, 1);
	Driver_Port_2.Sub(32'h0000ffff, 32'h0000ffff, 2);
	Driver_Port_2.Sub(32'h0000ffff, 32'h0000ffff, 3);
	#clk_period;
	
	Driver_Port_2.Sub(32'h0000ffff, 32'h000fffff, 0);
	Driver_Port_2.Sub(32'h0000ffff, 32'h000fffff, 1);
	Driver_Port_2.Sub(32'h0000ffff, 32'h000fffff, 2);
	Driver_Port_2.Sub(32'h0000ffff, 32'h000fffff, 3);
	#clk_period;
	
	Driver_Port_2.Sub(32'h00000000, 32'hffffffff, 0);
	Driver_Port_2.Sub(32'h00000000, 32'hffffffff, 1);
	Driver_Port_2.Sub(32'h00000000, 32'hffffffff, 2);
	Driver_Port_2.Sub(32'h00000000, 32'hffffffff, 3);
	#clk_period;
	
	Driver_Port_2.Sub(32'h0000000e, 32'h0000000f, 0);
	Driver_Port_2.Sub(32'h0000000e, 32'h0000000f, 1);
	Driver_Port_2.Sub(32'h0000000e, 32'h0000000f, 2);
	Driver_Port_2.Sub(32'h0000000e, 32'h0000000f, 3);
	#clk_period;
	
	Driver_Port_2.Sub(32'h00000002, 32'h00000002, 0);
	Driver_Port_2.Sub(32'h00000002, 32'h00000002, 1);
	Driver_Port_2.Sub(32'h00000002, 32'h00000002, 2);
	Driver_Port_2.Sub(32'h00000002, 32'h00000002, 3);
	#clk_period;
	
	Driver_Port_2.Sub(32'h00000002, 32'h00000003, 0);
	Driver_Port_2.Sub(32'h00000002, 32'h00000003, 1);
	Driver_Port_2.Sub(32'h00000002, 32'h00000003, 2);
	Driver_Port_2.Sub(32'h00000002, 32'h00000003, 3);
	#clk_period;
	
	Driver_Port_2.Sub(32'hffffffff, 32'hffffffff, 0);
	Driver_Port_2.Sub(32'hffffffff, 32'hffffffff, 1);
	Driver_Port_2.Sub(32'hffffffff, 32'hffffffff, 2);
	Driver_Port_2.Sub(32'hffffffff, 32'hffffffff, 3);
	#clk_period;
	
	Driver_Port_2.Sub(32'hffffffff, 32'h00000000, 0);
	Driver_Port_2.Sub(32'hffffffff, 32'h00000000, 1);
	Driver_Port_2.Sub(32'hffffffff, 32'h00000000, 2);
	Driver_Port_2.Sub(32'hffffffff, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_2.Sub(32'hefffffff, 32'hffffffff, 0);
	Driver_Port_2.Sub(32'hefffffff, 32'hffffffff, 1);
	Driver_Port_2.Sub(32'hefffffff, 32'hffffffff, 2);
	Driver_Port_2.Sub(32'hefffffff, 32'hffffffff, 3);
	
	
	
	
	Driver_Port_2.ShiftLeft(32'h00000000, 32'h00000000, 0);
	Driver_Port_2.ShiftLeft(32'h00000000, 32'h00000000, 1);
	Driver_Port_2.ShiftLeft(32'h00000000, 32'h00000000, 2);
	Driver_Port_2.ShiftLeft(32'h00000000, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_2.ShiftLeft(32'h00000000, 32'h00000001, 0);
	Driver_Port_2.ShiftLeft(32'h00000000, 32'h00000001, 1);
	Driver_Port_2.ShiftLeft(32'h00000000, 32'h00000001, 2);
	Driver_Port_2.ShiftLeft(32'h00000000, 32'h00000001, 3);	
	#clk_period;
	
	Driver_Port_2.ShiftLeft(32'h00000000, 32'h00000010, 0);
	Driver_Port_2.ShiftLeft(32'h00000000, 32'h00000010, 1);
	Driver_Port_2.ShiftLeft(32'h00000000, 32'h00000010, 2);
	Driver_Port_2.ShiftLeft(32'h00000000, 32'h00000010, 3);	
	#clk_period;
	
	Driver_Port_2.ShiftLeft(32'hffffffff, 32'h00000000, 0);
	Driver_Port_2.ShiftLeft(32'hffffffff, 32'h00000000, 1);
	Driver_Port_2.ShiftLeft(32'hffffffff, 32'h00000000, 2);
	Driver_Port_2.ShiftLeft(32'hffffffff, 32'h00000000, 3);
	#clk_period;
		
	Driver_Port_2.ShiftLeft(32'hffffffff, 32'h00000001, 0);
	Driver_Port_2.ShiftLeft(32'hffffffff, 32'h00000001, 1);
	Driver_Port_2.ShiftLeft(32'hffffffff, 32'h00000001, 2);
	Driver_Port_2.ShiftLeft(32'hffffffff, 32'h00000001, 3);	
	#clk_period;
	
	Driver_Port_2.ShiftLeft(32'h0fffffff, 32'h0000000f, 0);
	Driver_Port_2.ShiftLeft(32'h0fffffff, 32'h0000000f, 1);
	Driver_Port_2.ShiftLeft(32'h0fffffff, 32'h0000000f, 2);
	Driver_Port_2.ShiftLeft(32'h0fffffff, 32'h0000000f, 3);
	#clk_period;
	
	Driver_Port_2.ShiftLeft(32'h00045200, 32'h00000fff, 0);
	Driver_Port_2.ShiftLeft(32'h00004200, 32'h00000fff, 1);
	Driver_Port_2.ShiftLeft(32'h0004f000, 32'h00000fff, 2);
	Driver_Port_2.ShiftLeft(32'h00000460, 32'h00000fff, 3);
	#clk_period;
	
	Driver_Port_2.ShiftLeft(32'h0fffffff, 32'h00000001, 0);
	Driver_Port_2.ShiftLeft(32'h0fffffff, 32'h00000001, 1);
	Driver_Port_2.ShiftLeft(32'h0fffffff, 32'h00000001, 2);
	Driver_Port_2.ShiftLeft(32'h0fffffff, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_2.ShiftLeft(32'hf0000000, 32'h00000100, 0);
	Driver_Port_2.ShiftLeft(32'hf0000000, 32'h00000100, 1);
	Driver_Port_2.ShiftLeft(32'hf0000000, 32'h00000100, 2);
	Driver_Port_2.ShiftLeft(32'hf0000000, 32'h00000100, 3);
	#clk_period;
	
	Driver_Port_2.ShiftLeft(32'hff000000, 32'h00001000, 0);
	Driver_Port_2.ShiftLeft(32'hff000000, 32'h00001000, 1);
	Driver_Port_2.ShiftLeft(32'hff000000, 32'h00001000, 2);
	Driver_Port_2.ShiftLeft(32'hff000000, 32'h00001000, 3);
	#clk_period;
	
	
	Driver_Port_2.ShiftRight(32'h0000000e, 32'h00000002, 0);
	Driver_Port_2.ShiftRight(32'h0000000e, 32'h00000002, 1);
	Driver_Port_2.ShiftRight(32'h0000000e, 32'h00000002, 2);
	Driver_Port_2.ShiftRight(32'h0000000e, 32'h00000002, 3);
	#clk_period;
	
	Driver_Port_2.ShiftRight(32'h0000000e, 32'h00000004, 0);
	Driver_Port_2.ShiftRight(32'h0000000e, 32'h00000004, 1);
	Driver_Port_2.ShiftRight(32'h0000000e, 32'h00000004, 2);
	Driver_Port_2.ShiftRight(32'h0000000e, 32'h00000004, 3);
	#clk_period;
	
	Driver_Port_2.ShiftRight(32'h00000000, 32'h00000000, 0);
	Driver_Port_2.ShiftRight(32'h00000000, 32'h00000000, 1);
	Driver_Port_2.ShiftRight(32'h00000000, 32'h00000000, 2);
	Driver_Port_2.ShiftRight(32'h00000000, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_2.ShiftRight(32'hffffffff, 32'h00000000, 0);
	Driver_Port_2.ShiftRight(32'hffffffff, 32'h00000000, 1);
	Driver_Port_2.ShiftRight(32'hffffffff, 32'h00000000, 2);
	Driver_Port_2.ShiftRight(32'hffffffff, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_2.ShiftRight(32'hffffffff, 32'hffffffff, 0);
	Driver_Port_2.ShiftRight(32'hffffffff, 32'hffffffff, 1);
	Driver_Port_2.ShiftRight(32'hffffffff, 32'hffffffff, 2);
	Driver_Port_2.ShiftRight(32'hffffffff, 32'hffffffff, 3);
	#clk_period;
	
	Driver_Port_2.ShiftRight(32'h00000000, 32'h00000001, 0);
	Driver_Port_2.ShiftRight(32'h00000000, 32'h00000001, 1);
	Driver_Port_2.ShiftRight(32'h00000000, 32'h00000001, 2);
	Driver_Port_2.ShiftRight(32'h00000000, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_2.ShiftRight(32'h00fff000, 32'h00001100, 0);
	Driver_Port_2.ShiftRight(32'h00fff000, 32'h00001100, 1);
	Driver_Port_2.ShiftRight(32'h00fff000, 32'h00001100, 2);
	Driver_Port_2.ShiftRight(32'h00fff000, 32'h00001100, 3);
	#clk_period;
	
	Driver_Port_2.ShiftRight(32'h00fff000, 32'h00001110, 0);
	Driver_Port_2.ShiftRight(32'h00fff000, 32'h00001110, 1);
	Driver_Port_2.ShiftRight(32'h00fff000, 32'h00001110, 2);
	Driver_Port_2.ShiftRight(32'h00fff000, 32'h00001110, 3);
	#clk_period;
	
	Driver_Port_2.ShiftRight(32'hfffffffe, 32'h00000000, 0);
	Driver_Port_2.ShiftRight(32'hfffffffe, 32'h00000000, 1);
	Driver_Port_2.ShiftRight(32'hfffffffe, 32'h00000000, 2);
	Driver_Port_2.ShiftRight(32'hfffffffe, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_2.ShiftRight(32'h00000001, 32'h00000001, 0);
	Driver_Port_2.ShiftRight(32'h00000001, 32'h00000001, 1);
	Driver_Port_2.ShiftRight(32'h00000001, 32'h00000001, 2);
	Driver_Port_2.ShiftRight(32'h00000001, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_2.ShiftRight(32'h0000000f, 32'h00000100, 0);
	Driver_Port_2.ShiftRight(32'h0000000f, 32'h00000100, 1);
	Driver_Port_2.ShiftRight(32'h0000000f, 32'h00000100, 2);
	Driver_Port_2.ShiftRight(32'h0000000f, 32'h00000100, 3);
	#clk_period;
	
	Driver_Port_2.ShiftRight(32'h00000fff, 32'h00001100, 0);
	Driver_Port_2.ShiftRight(32'h00000fff, 32'h00001100, 1);
	Driver_Port_2.ShiftRight(32'h00000fff, 32'h00001100, 2);
	Driver_Port_2.ShiftRight(32'h00000fff, 32'h00001100, 3);
	#clk_period;

	
	end
	
endtask
///********************************************************************///

task testP3();
	begin

	Driver_Port_3.Add(32'h00000000, 32'h00000000, 0);
	Driver_Port_3.Add(32'h00000000, 32'h00000000, 1);
	Driver_Port_3.Add(32'h00000000, 32'h00000000, 2);
	Driver_Port_3.Add(32'h00000000, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_3.Add(32'h00501401, 32'h00000215, 0);
	Driver_Port_3.Add(32'h00501402, 32'h00000215, 1);
	Driver_Port_3.Add(32'h00501403, 32'h00000215, 2);
	Driver_Port_3.Add(32'h00501404, 32'h00000215, 3);
	#clk_period;
	
	Driver_Port_3.Add(32'h00000000, 32'h00004000, 0);
	Driver_Port_3.Add(32'h00000000, 32'h00000500, 1);
	Driver_Port_3.Add(32'h00000000, 32'h00030000, 2);
	Driver_Port_3.Add(32'h00000000, 32'h00008000, 3);
	#clk_period;
	
	Driver_Port_3.Add(32'hffffffff, 32'h00000000, 0);
	Driver_Port_3.Add(32'hffffffff, 32'h00000000, 1);
	Driver_Port_3.Add(32'hffffffff, 32'h00000000, 2);
	Driver_Port_3.Add(32'hffffffff, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_3.Add(32'hffffffff, 32'h00000001, 0);
	Driver_Port_3.Add(32'hffffffff, 32'h00000001, 1);
	Driver_Port_3.Add(32'hffffffff, 32'h00000001, 2);
	Driver_Port_3.Add(32'hffffffff, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_3.Add(32'hfffffffe, 32'h00000002, 0);
	Driver_Port_3.Add(32'hfffffffe, 32'h00000002, 1);
	Driver_Port_3.Add(32'hfffffffe, 32'h00000002, 2);
	Driver_Port_3.Add(32'hfffffffe, 32'h00000002, 3);
	#clk_period;
	
	Driver_Port_3.Add(32'hfffffffd, 32'h00000003, 0);
	Driver_Port_3.Add(32'hfffffffd, 32'h00000003, 1);
	Driver_Port_3.Add(32'hfffffffd, 32'h00000003, 2);
	Driver_Port_3.Add(32'hfffffffd, 32'h00000003, 3);
	#clk_period;
	
	Driver_Port_3.Add(32'h0000ffff, 32'hffff0000, 0);
	Driver_Port_3.Add(32'h0000ffff, 32'hffff0000, 1);
	Driver_Port_3.Add(32'h0000ffff, 32'hffff0000, 2);
	Driver_Port_3.Add(32'h0000ffff, 32'hffff0000, 3);
	#clk_period;
	
	Driver_Port_3.Add(32'h1000ffff, 32'hffff0000, 0);
	Driver_Port_3.Add(32'h1000ffff, 32'hffff0000, 1);
	Driver_Port_3.Add(32'h1000ffff, 32'hffff0000, 2);
	Driver_Port_3.Add(32'h1000ffff, 32'hffff0000, 3);
	#clk_period;
	
	Driver_Port_3.Add(32'h0000ffff, 32'hffff0001, 0);
	Driver_Port_3.Add(32'h0000ffff, 32'hffff0001, 1);
	Driver_Port_3.Add(32'h0000ffff, 32'hffff0001, 2);
	Driver_Port_3.Add(32'h0000ffff, 32'hffff0001, 3);
	#clk_period;
	
	Driver_Port_3.Add(32'h0000ffff, 32'hfffe0000, 0);
	Driver_Port_3.Add(32'h0000ffff, 32'hffff0e00, 1);
	Driver_Port_3.Add(32'h0000ffff, 32'hffffe000, 2);
	Driver_Port_3.Add(32'h0000ffff, 32'hffff00e0, 3);
	#clk_period;
	
	Driver_Port_3.Add(32'h0000ffff, 32'h0000ffff, 0);
	Driver_Port_3.Add(32'h0000ffff, 32'h0000ffff, 1);
	Driver_Port_3.Add(32'h0000ffff, 32'h0000ffff, 2);
	Driver_Port_3.Add(32'h0000ffff, 32'h0000ffff, 3);
	#clk_period;
	
	
	Driver_Port_3.Sub(32'h00000000, 32'h00000000, 0);
	Driver_Port_3.Sub(32'h00000000, 32'h00000000, 1);
	Driver_Port_3.Sub(32'h00000000, 32'h00000000, 2);
	Driver_Port_3.Sub(32'h00000000, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_3.Sub(32'h00000000, 32'h00000001, 0);
	Driver_Port_3.Sub(32'h00000000, 32'h00000001, 1);
	Driver_Port_3.Sub(32'h00000000, 32'h00000001, 2);
	Driver_Port_3.Sub(32'h00000000, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_3.Sub(32'h00003450, 32'h00000031, 0);
	Driver_Port_3.Sub(32'h00022000, 32'h00000011, 1);
	Driver_Port_3.Sub(32'h00000341, 32'h00000301, 2);
	Driver_Port_3.Sub(32'h00000020, 32'h00000005, 3);
	#clk_period;
	
	Driver_Port_3.Sub(32'h00003450, 32'h00030031, 0);
	Driver_Port_3.Sub(32'h00022000, 32'h00300011, 1);
	Driver_Port_3.Sub(32'h00000341, 32'h00003301, 2);
	Driver_Port_3.Sub(32'h00000020, 32'h00003005, 3);
	#clk_period;
	
	Driver_Port_3.Sub(32'h0000ffff, 32'h0000ffff, 0);
	Driver_Port_3.Sub(32'h0000ffff, 32'h0000ffff, 1);
	Driver_Port_3.Sub(32'h0000ffff, 32'h0000ffff, 2);
	Driver_Port_3.Sub(32'h0000ffff, 32'h0000ffff, 3);
	#clk_period;
	
	Driver_Port_3.Sub(32'h0000ffff, 32'h000fffff, 0);
	Driver_Port_3.Sub(32'h0000ffff, 32'h000fffff, 1);
	Driver_Port_3.Sub(32'h0000ffff, 32'h000fffff, 2);
	Driver_Port_3.Sub(32'h0000ffff, 32'h000fffff, 3);
	#clk_period;
	
	Driver_Port_3.Sub(32'h00000000, 32'hffffffff, 0);
	Driver_Port_3.Sub(32'h00000000, 32'hffffffff, 1);
	Driver_Port_3.Sub(32'h00000000, 32'hffffffff, 2);
	Driver_Port_3.Sub(32'h00000000, 32'hffffffff, 3);
	#clk_period;
	
	Driver_Port_3.Sub(32'h0000000e, 32'h0000000f, 0);
	Driver_Port_3.Sub(32'h0000000e, 32'h0000000f, 1);
	Driver_Port_3.Sub(32'h0000000e, 32'h0000000f, 2);
	Driver_Port_3.Sub(32'h0000000e, 32'h0000000f, 3);
	#clk_period;
	
	Driver_Port_3.Sub(32'h00000002, 32'h00000002, 0);
	Driver_Port_3.Sub(32'h00000002, 32'h00000002, 1);
	Driver_Port_3.Sub(32'h00000002, 32'h00000002, 2);
	Driver_Port_3.Sub(32'h00000002, 32'h00000002, 3);
	#clk_period;
	
	Driver_Port_3.Sub(32'h00000002, 32'h00000003, 0);
	Driver_Port_3.Sub(32'h00000002, 32'h00000003, 1);
	Driver_Port_3.Sub(32'h00000002, 32'h00000003, 2);
	Driver_Port_3.Sub(32'h00000002, 32'h00000003, 3);
	#clk_period;
	
	Driver_Port_3.Sub(32'hffffffff, 32'hffffffff, 0);
	Driver_Port_3.Sub(32'hffffffff, 32'hffffffff, 1);
	Driver_Port_3.Sub(32'hffffffff, 32'hffffffff, 2);
	Driver_Port_3.Sub(32'hffffffff, 32'hffffffff, 3);
	#clk_period;
	
	Driver_Port_3.Sub(32'hffffffff, 32'h00000000, 0);
	Driver_Port_3.Sub(32'hffffffff, 32'h00000000, 1);
	Driver_Port_3.Sub(32'hffffffff, 32'h00000000, 2);
	Driver_Port_3.Sub(32'hffffffff, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_3.Sub(32'hefffffff, 32'hffffffff, 0);
	Driver_Port_3.Sub(32'hefffffff, 32'hffffffff, 1);
	Driver_Port_3.Sub(32'hefffffff, 32'hffffffff, 2);
	Driver_Port_3.Sub(32'hefffffff, 32'hffffffff, 3);
	
	
	
	
	Driver_Port_3.ShiftLeft(32'h00000000, 32'h00000000, 0);
	Driver_Port_3.ShiftLeft(32'h00000000, 32'h00000000, 1);
	Driver_Port_3.ShiftLeft(32'h00000000, 32'h00000000, 2);
	Driver_Port_3.ShiftLeft(32'h00000000, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_3.ShiftLeft(32'h00000000, 32'h00000001, 0);
	Driver_Port_3.ShiftLeft(32'h00000000, 32'h00000001, 1);
	Driver_Port_3.ShiftLeft(32'h00000000, 32'h00000001, 2);
	Driver_Port_3.ShiftLeft(32'h00000000, 32'h00000001, 3);	
	#clk_period;
	
	Driver_Port_3.ShiftLeft(32'h00000000, 32'h00000010, 0);
	Driver_Port_3.ShiftLeft(32'h00000000, 32'h00000010, 1);
	Driver_Port_3.ShiftLeft(32'h00000000, 32'h00000010, 2);
	Driver_Port_3.ShiftLeft(32'h00000000, 32'h00000010, 3);	
	#clk_period;
	
	Driver_Port_3.ShiftLeft(32'hffffffff, 32'h00000000, 0);
	Driver_Port_3.ShiftLeft(32'hffffffff, 32'h00000000, 1);
	Driver_Port_3.ShiftLeft(32'hffffffff, 32'h00000000, 2);
	Driver_Port_3.ShiftLeft(32'hffffffff, 32'h00000000, 3);
	#clk_period;
		
	Driver_Port_3.ShiftLeft(32'hffffffff, 32'h00000001, 0);
	Driver_Port_3.ShiftLeft(32'hffffffff, 32'h00000001, 1);
	Driver_Port_3.ShiftLeft(32'hffffffff, 32'h00000001, 2);
	Driver_Port_3.ShiftLeft(32'hffffffff, 32'h00000001, 3);	
	#clk_period;
	
	Driver_Port_3.ShiftLeft(32'h0fffffff, 32'h0000000f, 0);
	Driver_Port_3.ShiftLeft(32'h0fffffff, 32'h0000000f, 1);
	Driver_Port_3.ShiftLeft(32'h0fffffff, 32'h0000000f, 2);
	Driver_Port_3.ShiftLeft(32'h0fffffff, 32'h0000000f, 3);
	#clk_period;
	
	Driver_Port_3.ShiftLeft(32'h00045200, 32'h00000fff, 0);
	Driver_Port_3.ShiftLeft(32'h00004200, 32'h00000fff, 1);
	Driver_Port_3.ShiftLeft(32'h0004f000, 32'h00000fff, 2);
	Driver_Port_3.ShiftLeft(32'h00000460, 32'h00000fff, 3);
	#clk_period;
	
	Driver_Port_3.ShiftLeft(32'h0fffffff, 32'h00000001, 0);
	Driver_Port_3.ShiftLeft(32'h0fffffff, 32'h00000001, 1);
	Driver_Port_3.ShiftLeft(32'h0fffffff, 32'h00000001, 2);
	Driver_Port_3.ShiftLeft(32'h0fffffff, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_3.ShiftLeft(32'hf0000000, 32'h00000100, 0);
	Driver_Port_3.ShiftLeft(32'hf0000000, 32'h00000100, 1);
	Driver_Port_3.ShiftLeft(32'hf0000000, 32'h00000100, 2);
	Driver_Port_3.ShiftLeft(32'hf0000000, 32'h00000100, 3);
	#clk_period;
	
	Driver_Port_3.ShiftLeft(32'hff000000, 32'h00001000, 0);
	Driver_Port_3.ShiftLeft(32'hff000000, 32'h00001000, 1);
	Driver_Port_3.ShiftLeft(32'hff000000, 32'h00001000, 2);
	Driver_Port_3.ShiftLeft(32'hff000000, 32'h00001000, 3);
	#clk_period;
	
	
	Driver_Port_3.ShiftRight(32'h0000000e, 32'h00000002, 0);
	Driver_Port_3.ShiftRight(32'h0000000e, 32'h00000002, 1);
	Driver_Port_3.ShiftRight(32'h0000000e, 32'h00000002, 2);
	Driver_Port_3.ShiftRight(32'h0000000e, 32'h00000002, 3);
	#clk_period;
	
	Driver_Port_3.ShiftRight(32'h0000000e, 32'h00000004, 0);
	Driver_Port_3.ShiftRight(32'h0000000e, 32'h00000004, 1);
	Driver_Port_3.ShiftRight(32'h0000000e, 32'h00000004, 2);
	Driver_Port_3.ShiftRight(32'h0000000e, 32'h00000004, 3);
	#clk_period;
	
	Driver_Port_3.ShiftRight(32'h00000000, 32'h00000000, 0);
	Driver_Port_3.ShiftRight(32'h00000000, 32'h00000000, 1);
	Driver_Port_3.ShiftRight(32'h00000000, 32'h00000000, 2);
	Driver_Port_3.ShiftRight(32'h00000000, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_3.ShiftRight(32'hffffffff, 32'h00000000, 0);
	Driver_Port_3.ShiftRight(32'hffffffff, 32'h00000000, 1);
	Driver_Port_3.ShiftRight(32'hffffffff, 32'h00000000, 2);
	Driver_Port_3.ShiftRight(32'hffffffff, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_3.ShiftRight(32'hffffffff, 32'hffffffff, 0);
	Driver_Port_3.ShiftRight(32'hffffffff, 32'hffffffff, 1);
	Driver_Port_3.ShiftRight(32'hffffffff, 32'hffffffff, 2);
	Driver_Port_3.ShiftRight(32'hffffffff, 32'hffffffff, 3);
	#clk_period;
	
	Driver_Port_3.ShiftRight(32'h00000000, 32'h00000001, 0);
	Driver_Port_3.ShiftRight(32'h00000000, 32'h00000001, 1);
	Driver_Port_3.ShiftRight(32'h00000000, 32'h00000001, 2);
	Driver_Port_3.ShiftRight(32'h00000000, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_3.ShiftRight(32'h00fff000, 32'h00001100, 0);
	Driver_Port_3.ShiftRight(32'h00fff000, 32'h00001100, 1);
	Driver_Port_3.ShiftRight(32'h00fff000, 32'h00001100, 2);
	Driver_Port_3.ShiftRight(32'h00fff000, 32'h00001100, 3);
	#clk_period;
	
	Driver_Port_3.ShiftRight(32'h00fff000, 32'h00001110, 0);
	Driver_Port_3.ShiftRight(32'h00fff000, 32'h00001110, 1);
	Driver_Port_3.ShiftRight(32'h00fff000, 32'h00001110, 2);
	Driver_Port_3.ShiftRight(32'h00fff000, 32'h00001110, 3);
	#clk_period;
	
	Driver_Port_3.ShiftRight(32'hfffffffe, 32'h00000000, 0);
	Driver_Port_3.ShiftRight(32'hfffffffe, 32'h00000000, 1);
	Driver_Port_3.ShiftRight(32'hfffffffe, 32'h00000000, 2);
	Driver_Port_3.ShiftRight(32'hfffffffe, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_3.ShiftRight(32'h00000001, 32'h00000001, 0);
	Driver_Port_3.ShiftRight(32'h00000001, 32'h00000001, 1);
	Driver_Port_3.ShiftRight(32'h00000001, 32'h00000001, 2);
	Driver_Port_3.ShiftRight(32'h00000001, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_3.ShiftRight(32'h0000000f, 32'h00000100, 0);
	Driver_Port_3.ShiftRight(32'h0000000f, 32'h00000100, 1);
	Driver_Port_3.ShiftRight(32'h0000000f, 32'h00000100, 2);
	Driver_Port_3.ShiftRight(32'h0000000f, 32'h00000100, 3);
	#clk_period;
	
	Driver_Port_3.ShiftRight(32'h00000fff, 32'h00001100, 0);
	Driver_Port_3.ShiftRight(32'h00000fff, 32'h00001100, 1);
	Driver_Port_3.ShiftRight(32'h00000fff, 32'h00001100, 2);
	Driver_Port_3.ShiftRight(32'h00000fff, 32'h00001100, 3);
	#clk_period;

	end
endtask

///********************************************************************///
task testP4();
	begin
	Driver_Port_4.Add(32'h00000000, 32'h00000000, 0);
	Driver_Port_4.Add(32'h00000000, 32'h00000000, 1);
	Driver_Port_4.Add(32'h00000000, 32'h00000000, 2);
	Driver_Port_4.Add(32'h00000000, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_4.Add(32'h00501401, 32'h00000215, 0);
	Driver_Port_4.Add(32'h00501402, 32'h00000215, 1);
	Driver_Port_4.Add(32'h00501403, 32'h00000215, 2);
	Driver_Port_4.Add(32'h00501404, 32'h00000215, 3);
	#clk_period;
	
	Driver_Port_4.Add(32'h00000000, 32'h00004000, 0);
	Driver_Port_4.Add(32'h00000000, 32'h00000500, 1);
	Driver_Port_4.Add(32'h00000000, 32'h00030000, 2);
	Driver_Port_4.Add(32'h00000000, 32'h00008000, 3);
	#clk_period;
	
	Driver_Port_4.Add(32'hffffffff, 32'h00000000, 0);
	Driver_Port_4.Add(32'hffffffff, 32'h00000000, 1);
	Driver_Port_4.Add(32'hffffffff, 32'h00000000, 2);
	Driver_Port_4.Add(32'hffffffff, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_4.Add(32'hffffffff, 32'h00000001, 0);
	Driver_Port_4.Add(32'hffffffff, 32'h00000001, 1);
	Driver_Port_4.Add(32'hffffffff, 32'h00000001, 2);
	Driver_Port_4.Add(32'hffffffff, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_4.Add(32'hfffffffe, 32'h00000002, 0);
	Driver_Port_4.Add(32'hfffffffe, 32'h00000002, 1);
	Driver_Port_4.Add(32'hfffffffe, 32'h00000002, 2);
	Driver_Port_4.Add(32'hfffffffe, 32'h00000002, 3);
	#clk_period;
	
	Driver_Port_4.Add(32'hfffffffd, 32'h00000003, 0);
	Driver_Port_4.Add(32'hfffffffd, 32'h00000003, 1);
	Driver_Port_4.Add(32'hfffffffd, 32'h00000003, 2);
	Driver_Port_4.Add(32'hfffffffd, 32'h00000003, 3);
	#clk_period;
	
	Driver_Port_4.Add(32'h0000ffff, 32'hffff0000, 0);
	Driver_Port_4.Add(32'h0000ffff, 32'hffff0000, 1);
	Driver_Port_4.Add(32'h0000ffff, 32'hffff0000, 2);
	Driver_Port_4.Add(32'h0000ffff, 32'hffff0000, 3);
	#clk_period;
	
	Driver_Port_4.Add(32'h1000ffff, 32'hffff0000, 0);
	Driver_Port_4.Add(32'h1000ffff, 32'hffff0000, 1);
	Driver_Port_4.Add(32'h1000ffff, 32'hffff0000, 2);
	Driver_Port_4.Add(32'h1000ffff, 32'hffff0000, 3);
	#clk_period;
	
	Driver_Port_4.Add(32'h0000ffff, 32'hffff0001, 0);
	Driver_Port_4.Add(32'h0000ffff, 32'hffff0001, 1);
	Driver_Port_4.Add(32'h0000ffff, 32'hffff0001, 2);
	Driver_Port_4.Add(32'h0000ffff, 32'hffff0001, 3);
	#clk_period;
	
	Driver_Port_4.Add(32'h0000ffff, 32'hfffe0000, 0);
	Driver_Port_4.Add(32'h0000ffff, 32'hffff0e00, 1);
	Driver_Port_4.Add(32'h0000ffff, 32'hffffe000, 2);
	Driver_Port_4.Add(32'h0000ffff, 32'hffff00e0, 3);
	#clk_period;
	
	Driver_Port_4.Add(32'h0000ffff, 32'h0000ffff, 0);
	Driver_Port_4.Add(32'h0000ffff, 32'h0000ffff, 1);
	Driver_Port_4.Add(32'h0000ffff, 32'h0000ffff, 2);
	Driver_Port_4.Add(32'h0000ffff, 32'h0000ffff, 3);
	#clk_period;
	
	
	Driver_Port_4.Sub(32'h00000000, 32'h00000000, 0);
	Driver_Port_4.Sub(32'h00000000, 32'h00000000, 1);
	Driver_Port_4.Sub(32'h00000000, 32'h00000000, 2);
	Driver_Port_4.Sub(32'h00000000, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_4.Sub(32'h00000000, 32'h00000001, 0);
	Driver_Port_4.Sub(32'h00000000, 32'h00000001, 1);
	Driver_Port_4.Sub(32'h00000000, 32'h00000001, 2);
	Driver_Port_4.Sub(32'h00000000, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_4.Sub(32'h00003450, 32'h00000031, 0);
	Driver_Port_4.Sub(32'h00022000, 32'h00000011, 1);
	Driver_Port_4.Sub(32'h00000341, 32'h00000301, 2);
	Driver_Port_4.Sub(32'h00000020, 32'h00000005, 3);
	#clk_period;
	
	Driver_Port_4.Sub(32'h00003450, 32'h00030031, 0);
	Driver_Port_4.Sub(32'h00022000, 32'h00300011, 1);
	Driver_Port_4.Sub(32'h00000341, 32'h00003301, 2);
	Driver_Port_4.Sub(32'h00000020, 32'h00003005, 3);
	#clk_period;
	
	Driver_Port_4.Sub(32'h0000ffff, 32'h0000ffff, 0);
	Driver_Port_4.Sub(32'h0000ffff, 32'h0000ffff, 1);
	Driver_Port_4.Sub(32'h0000ffff, 32'h0000ffff, 2);
	Driver_Port_4.Sub(32'h0000ffff, 32'h0000ffff, 3);
	#clk_period;
	
	Driver_Port_4.Sub(32'h0000ffff, 32'h000fffff, 0);
	Driver_Port_4.Sub(32'h0000ffff, 32'h000fffff, 1);
	Driver_Port_4.Sub(32'h0000ffff, 32'h000fffff, 2);
	Driver_Port_4.Sub(32'h0000ffff, 32'h000fffff, 3);
	#clk_period;
	
	Driver_Port_4.Sub(32'h00000000, 32'hffffffff, 0);
	Driver_Port_4.Sub(32'h00000000, 32'hffffffff, 1);
	Driver_Port_4.Sub(32'h00000000, 32'hffffffff, 2);
	Driver_Port_4.Sub(32'h00000000, 32'hffffffff, 3);
	#clk_period;
	
	Driver_Port_4.Sub(32'h0000000e, 32'h0000000f, 0);
	Driver_Port_4.Sub(32'h0000000e, 32'h0000000f, 1);
	Driver_Port_4.Sub(32'h0000000e, 32'h0000000f, 2);
	Driver_Port_4.Sub(32'h0000000e, 32'h0000000f, 3);
	#clk_period;
	
	Driver_Port_4.Sub(32'h00000002, 32'h00000002, 0);
	Driver_Port_4.Sub(32'h00000002, 32'h00000002, 1);
	Driver_Port_4.Sub(32'h00000002, 32'h00000002, 2);
	Driver_Port_4.Sub(32'h00000002, 32'h00000002, 3);
	#clk_period;
	
	Driver_Port_4.Sub(32'h00000002, 32'h00000003, 0);
	Driver_Port_4.Sub(32'h00000002, 32'h00000003, 1);
	Driver_Port_4.Sub(32'h00000002, 32'h00000003, 2);
	Driver_Port_4.Sub(32'h00000002, 32'h00000003, 3);
	#clk_period;
	
	Driver_Port_4.Sub(32'hffffffff, 32'hffffffff, 0);
	Driver_Port_4.Sub(32'hffffffff, 32'hffffffff, 1);
	Driver_Port_4.Sub(32'hffffffff, 32'hffffffff, 2);
	Driver_Port_4.Sub(32'hffffffff, 32'hffffffff, 3);
	#clk_period;

	Driver_Port_4.ShiftLeft(32'hff000000, 32'h00001000, 0);
	Driver_Port_4.ShiftLeft(32'hff000000, 32'h00001000, 1);
	Driver_Port_4.ShiftLeft(32'hff000000, 32'h00001000, 2);
	Driver_Port_4.ShiftLeft(32'hff000000, 32'h00001000, 3);
	#clk_period;
	
	
	Driver_Port_4.ShiftRight(32'h0000000e, 32'h00000002, 0);
	Driver_Port_4.ShiftRight(32'h0000000e, 32'h00000002, 1);
	Driver_Port_4.ShiftRight(32'h0000000e, 32'h00000002, 2);
	Driver_Port_4.ShiftRight(32'h0000000e, 32'h00000002, 3);
	#clk_period;
	
	Driver_Port_4.ShiftRight(32'h0000000e, 32'h00000004, 0);
	Driver_Port_4.ShiftRight(32'h0000000e, 32'h00000004, 1);
	Driver_Port_4.ShiftRight(32'h0000000e, 32'h00000004, 2);
	Driver_Port_4.ShiftRight(32'h0000000e, 32'h00000004, 3);
	#clk_period;
	
	Driver_Port_4.ShiftRight(32'h00000000, 32'h00000000, 0);
	Driver_Port_4.ShiftRight(32'h00000000, 32'h00000000, 1);
	Driver_Port_4.ShiftRight(32'h00000000, 32'h00000000, 2);
	Driver_Port_4.ShiftRight(32'h00000000, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_4.ShiftRight(32'hffffffff, 32'h00000000, 0);
	Driver_Port_4.ShiftRight(32'hffffffff, 32'h00000000, 1);
	Driver_Port_4.ShiftRight(32'hffffffff, 32'h00000000, 2);
	Driver_Port_4.ShiftRight(32'hffffffff, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_4.ShiftRight(32'hffffffff, 32'hffffffff, 0);
	Driver_Port_4.ShiftRight(32'hffffffff, 32'hffffffff, 1);
	Driver_Port_4.ShiftRight(32'hffffffff, 32'hffffffff, 2);
	Driver_Port_4.ShiftRight(32'hffffffff, 32'hffffffff, 3);
	#clk_period;
	
	Driver_Port_4.ShiftRight(32'h00000000, 32'h00000001, 0);
	Driver_Port_4.ShiftRight(32'h00000000, 32'h00000001, 1);
	Driver_Port_4.ShiftRight(32'h00000000, 32'h00000001, 2);
	Driver_Port_4.ShiftRight(32'h00000000, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_4.ShiftRight(32'h00fff000, 32'h00001100, 0);
	Driver_Port_4.ShiftRight(32'h00fff000, 32'h00001100, 1);
	Driver_Port_4.ShiftRight(32'h00fff000, 32'h00001100, 2);
	Driver_Port_4.ShiftRight(32'h00fff000, 32'h00001100, 3);
	#clk_period;
	
	Driver_Port_4.ShiftRight(32'h00fff000, 32'h00001110, 0);
	Driver_Port_4.ShiftRight(32'h00fff000, 32'h00001110, 1);
	Driver_Port_4.ShiftRight(32'h00fff000, 32'h00001110, 2);
	Driver_Port_4.ShiftRight(32'h00fff000, 32'h00001110, 3);
	#clk_period;
	
	Driver_Port_4.ShiftRight(32'hfffffffe, 32'h00000000, 0);
	Driver_Port_4.ShiftRight(32'hfffffffe, 32'h00000000, 1);
	Driver_Port_4.ShiftRight(32'hfffffffe, 32'h00000000, 2);
	Driver_Port_4.ShiftRight(32'hfffffffe, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_4.ShiftRight(32'h00000001, 32'h00000001, 0);
	Driver_Port_4.ShiftRight(32'h00000001, 32'h00000001, 1);
	Driver_Port_4.ShiftRight(32'h00000001, 32'h00000001, 2);
	Driver_Port_4.ShiftRight(32'h00000001, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_4.ShiftRight(32'h0000000f, 32'h00000100, 0);
	Driver_Port_4.ShiftRight(32'h0000000f, 32'h00000100, 1);
	Driver_Port_4.ShiftRight(32'h0000000f, 32'h00000100, 2);
	Driver_Port_4.ShiftRight(32'h0000000f, 32'h00000100, 3);
	#clk_period;
	
	Driver_Port_4.ShiftRight(32'h00000fff, 32'h00001100, 0);
	Driver_Port_4.ShiftRight(32'h00000fff, 32'h00001100, 1);
	Driver_Port_4.ShiftRight(32'h00000fff, 32'h00001100, 2);
	Driver_Port_4.ShiftRight(32'h00000fff, 32'h00001100, 3);
	#clk_period;

	
	Driver_Port_4.Sub(32'hffffffff, 32'h00000000, 0);
	Driver_Port_4.Sub(32'hffffffff, 32'h00000000, 1);
	Driver_Port_4.Sub(32'hffffffff, 32'h00000000, 2);
	Driver_Port_4.Sub(32'hffffffff, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_4.Sub(32'hefffffff, 32'hffffffff, 0);
	Driver_Port_4.Sub(32'hefffffff, 32'hffffffff, 1);
	Driver_Port_4.Sub(32'hefffffff, 32'hffffffff, 2);
	Driver_Port_4.Sub(32'hefffffff, 32'hffffffff, 3);
	
	
	
	
	Driver_Port_4.ShiftLeft(32'h00000000, 32'h00000000, 0);
	Driver_Port_4.ShiftLeft(32'h00000000, 32'h00000000, 1);
	Driver_Port_4.ShiftLeft(32'h00000000, 32'h00000000, 2);
	Driver_Port_4.ShiftLeft(32'h00000000, 32'h00000000, 3);
	#clk_period;
	
	Driver_Port_4.ShiftLeft(32'h00000000, 32'h00000001, 0);
	Driver_Port_4.ShiftLeft(32'h00000000, 32'h00000001, 1);
	Driver_Port_4.ShiftLeft(32'h00000000, 32'h00000001, 2);
	Driver_Port_4.ShiftLeft(32'h00000000, 32'h00000001, 3);	
	#clk_period;
	
	Driver_Port_4.ShiftLeft(32'h00000000, 32'h00000010, 0);
	Driver_Port_4.ShiftLeft(32'h00000000, 32'h00000010, 1);
	Driver_Port_4.ShiftLeft(32'h00000000, 32'h00000010, 2);
	Driver_Port_4.ShiftLeft(32'h00000000, 32'h00000010, 3);	
	#clk_period;
	
	Driver_Port_4.ShiftLeft(32'hffffffff, 32'h00000000, 0);
	Driver_Port_4.ShiftLeft(32'hffffffff, 32'h00000000, 1);
	Driver_Port_4.ShiftLeft(32'hffffffff, 32'h00000000, 2);
	Driver_Port_4.ShiftLeft(32'hffffffff, 32'h00000000, 3);
	#clk_period;
		
	Driver_Port_4.ShiftLeft(32'hffffffff, 32'h00000001, 0);
	Driver_Port_4.ShiftLeft(32'hffffffff, 32'h00000001, 1);
	Driver_Port_4.ShiftLeft(32'hffffffff, 32'h00000001, 2);
	Driver_Port_4.ShiftLeft(32'hffffffff, 32'h00000001, 3);	
	#clk_period;
	
	Driver_Port_4.ShiftLeft(32'h0fffffff, 32'h0000000f, 0);
	Driver_Port_4.ShiftLeft(32'h0fffffff, 32'h0000000f, 1);
	Driver_Port_4.ShiftLeft(32'h0fffffff, 32'h0000000f, 2);
	Driver_Port_4.ShiftLeft(32'h0fffffff, 32'h0000000f, 3);
	#clk_period;
	
	Driver_Port_4.ShiftLeft(32'h00045200, 32'h00000fff, 0);
	Driver_Port_4.ShiftLeft(32'h00004200, 32'h00000fff, 1);
	Driver_Port_4.ShiftLeft(32'h0004f000, 32'h00000fff, 2);
	Driver_Port_4.ShiftLeft(32'h00000460, 32'h00000fff, 3);
	#clk_period;
	
	Driver_Port_4.ShiftLeft(32'h0fffffff, 32'h00000001, 0);
	Driver_Port_4.ShiftLeft(32'h0fffffff, 32'h00000001, 1);
	Driver_Port_4.ShiftLeft(32'h0fffffff, 32'h00000001, 2);
	Driver_Port_4.ShiftLeft(32'h0fffffff, 32'h00000001, 3);
	#clk_period;
	
	Driver_Port_4.ShiftLeft(32'hf0000000, 32'h00000100, 0);
	Driver_Port_4.ShiftLeft(32'hf0000000, 32'h00000100, 1);
	Driver_Port_4.ShiftLeft(32'hf0000000, 32'h00000100, 2);
	Driver_Port_4.ShiftLeft(32'hf0000000, 32'h00000100, 3);
	#clk_period;
	

	end
endtask


///********************************************************************///	
task Reset();
	 begin
	 @(posedge portGlb.c_clk)
		port1.req_cmd_in = 0;
		port2.req_cmd_in = 0;
		port3.req_cmd_in = 0;
		port4.req_cmd_in = 0;
		
		port1.req_data_in = 0;
		port2.req_data_in = 0;
		port3.req_data_in = 0;
		port4.req_data_in = 0;
		
		port1.req_tag_in = 0;
		port2.req_tag_in = 0;
		port3.req_tag_in = 0;
		port4.req_tag_in = 0;
		
		portGlb.reset = 1;
	$write("%t : Reset asserted\n", $time);
	repeat(2)@(posedge portGlb.c_clk);
	#20 portGlb.reset = 0;
	$write("%t : Reset disasserted\n", $time);
	  end
endtask
///********************************************************************//
endclass