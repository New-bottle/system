/* ACM Class System (I) 2017 Fall Homework 1 
 *
 * Part I: Write an adder in Verilog
 *
 * Implement your naive adder here
 * 
 * GUIDE:
 *   1. Create a RTL project in Vivado
 *   2. Put this file into `Sources'
 *   3. Put `test_adder.v' into `Simulation Sources'
 *   4. Run Behavioral Simulation
 *   5. Make sure to run at least 100 steps during the simulation (usually 100ns)
 *   6. You can see the results in `Tcl console'
 *
 */

module Add_half(output c_out, sum, input a, b);
    xor M1 (sum, a, b);
    and M2 (c_out, a, b);
endmodule

module adder_1_bit(output c_out, sum, input a, b, c_in);
    wire w1, w2, w3;
    Add_half M1 (w2, w1, a, b);
    Add_half M2 (w3, sum, c_in, w1);
    or       M3 (c_out, w2, w3);
endmodule

module adder_4_bit(output c_out, output [3:0] sum, input [3:0] a, b, input c_in);
    wire c_in2, c_in3, c_in4;
    adder_1_bit  M1   (c_in2,   sum[0],   a[0],  b[0], c_in);
    adder_1_bit  M2   (c_in3,   sum[1],   a[1],  b[1], c_in2);
    adder_1_bit  M3   (c_in4,   sum[2],   a[2],  b[2], c_in3);
    adder_1_bit  M4   (c_out,   sum[3],   a[3],  b[3], c_in4);
endmodule

module adder(
    input [15:0] IN1, IN2,
    output [15:0] OUT
	// TODO: Write the ports of this module here
	//
	// Hint: 
	//   The module needs 3 ports, 
	//     the first 2 ports are 16-bit unsigned numbers as the inputs of the adder
	//     the third port is a 16-bit unsigned number as the output
	// 
);
	// TODO: Implement this module here
	wire  c_in1, c_in2, c_in3, c_in4, c_out;
	adder_4_bit  M1  (c_in2,  OUT[3:0],    IN1[3:0],    IN2[3:0],    0);
	adder_4_bit  M2  (c_in3,  OUT[7:4],    IN1[7:4],    IN2[7:4],    c_in2);
	adder_4_bit  M3  (c_in4,  OUT[11:8],   IN1[11:8],   IN2[11:8],   c_in3);
	adder_4_bit  M4  (c_out,  OUT[15:12],  IN1[15:12],  IN2[15:12],  c_in4);
	
endmodule
