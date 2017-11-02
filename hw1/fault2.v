/* ACM Class System (I) 2017 Fall Homework 1 
 *
 * PART II: Correct the following program
 * 
 * GUIDE:
 *   1. Create a RTL project in Vivado
 *   2. Put this file into `Simulation Sources'
 *   3. Run Behavioral Simulation
 *   4. You can see the results in `Tcl console'
 *
 */

module testfault;
	reg[15:0] a,b;
	wire[15:0] answer;
	fault f(a,b,answer);
	initial begin
		a = 10;
		b = 20;
		
		#1;
		if(answer != 20) begin
			$display("Expected 20, got %d", answer);
			$fatal(2);
		end
		
		#1;
		
		a = 40;
		b = 30;
		
		#1;
		
		if(answer != 40) begin
			$display("Expected 40, got %d", answer);
			$fatal(1);
		end
		
		$display("Congratulations! You have passed this test.");
		$finish;
	end
endmodule

module bigger(input [15:0] a, input [15:0] b, output c);
	wire [15:0] y;
	integer i;
	reg answer;
always @(a or b or c) begin
	for (i = 15; i >= 0; i = i - 1) begin:one
		if (a[i] > b[i]) begin
			assign answer = 1'b1;
			disable one;
		end
	end
end
	assign c = answer;
endmodule

module fault(a,b,answer);
	input wire[15:0] a,b;
	output reg[15:0] answer;
	wire c;
	bigger big1 (a, b, c);
always @(a or b or answer) begin
	if(c != 1'b0)
		assign answer=a;
	else
		assign answer=b;
end
endmodule

