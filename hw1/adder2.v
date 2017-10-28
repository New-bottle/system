/* ACM Class System (I) 2017 Fall Homework 1 
 *
 * Part I: Write an adder in Verilog
 *
 * Implement your Carry Look Ahead Adder here
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

module adder_4_bit(output c_out, output [3:0] sum, PG, GG, input [3:0] a, b, input c_in);
    wire [3:0] G,P;
    wire [3:0] C;
    assign G = a & b;
    assign P = a ^ b;
    
    assign C[0] = G[0] | (P[0] & c_in);
    
    assign C[1] = G[1] | (P[1] & C[0]);
    assign C[2] = G[2] | (P[2] & C[1]);
    assign C[3] = G[3] | (P[3] & C[2]);
    
    assign sum[0] = P[0] ^ c_in;
    assign sum[3:1] = P[3:1] ^ C[2:0];
    
	assign c_out = C[3];
	assign PG = P[0] & P[1] & P[2] & P[3];
	assign GG = G[3] ^ (G[2] & P[3]) ^ (G[1] & P[2] & P[3]) ^ (G[0] & P[1] & P[2] & P[3]);
endmodule

module CLA(input [3:0] P, G, input c0, output PG, GG, output [4:1] c1to4);
    wire [4:0] C;
    
    assign c1to4 = C[4:1];
    assign PG = &P;
    assign GG = G[3] | (G[2] & P[3]) | 
module adder(
    input [15:0] a, b,
    output [15:0] sum
	// TODO: Write the ports of this module here
	//
	// Hint: 
	//   The module needs 3 ports, 
	//     the first 2 ports are 16-bit unsigned numbers as the inputs of the adder
	//     the third port is a 16-bit unsigned number as the output
	// 
);
	// TODO: Implement this module here
	wire [3:0] c_in;
	wire c_out;
	adder_4_bit M1 (c_sin[1], sum[3:0],   P[0], G[0],  a[3:0],    b[3:0],   0);
	adder_4_bit M2 (c_in[2], sum[7:4],   P[1], G[1],  a[7:4],    b[7:4],   c_in[1]);
	adder_4_bit M3 (c_in[3], sum[11:8],  P[2], G[2],  a[11:8],   b[11:8],  c_in[2]);
	adder_4_bit M4 (c_out,   sum[15:12], P[3], G[3],  a[15:12],  b[15:12], c_in[3]);
	
	
endmodule
