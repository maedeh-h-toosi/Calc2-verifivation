`include "interface.sv"
`include "generator.sv"
`include "checker.sv"

//instance our interface
program top_test (
  	Port_Global Global,
  	Port_Stimuli Port_1,
  	Port_Stimuli Port_2,
  	Port_Stimuli Port_3,
  	Port_Stimuli Port_4,

	Port_Checker Checker_Port1 ,
	Port_Checker Checker_Port2 ,
	Port_Checker Checker_Port3 ,
	Port_Checker Checker_Port4);

	event Finish;

  Checker  Check_Port1 = new(1, Checker_Port1,Global ,Finish);
  Checker  Check_Port2 = new(2, Checker_Port2,Global ,Finish);
  Checker  Check_Port3 = new(3, Checker_Port3,Global ,Finish);
  Checker  Check_Port4 = new(4, Checker_Port4,Global ,Finish);

//create object of generator and start simulation
 Generator Global_Generator = new(Global, Port_1, Port_2, Port_3, Port_4,Finish);
       initial begin
  		$write ("%t: Simulation started \n", $time);
  		fork
    		Global_Generator.Start();
		Check_Port1.Start();
		Check_Port2.Start();
		Check_Port3.Start();
		Check_Port4.Start();
  		join
  		$write ("%t: Simulation finished \n", $time);
     	end

endprogram



