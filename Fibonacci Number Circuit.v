// 	Fibonacci Number Circuit


module Fibonacci_Number_Circuit 
	(
		input 		clk,    // Clock
		input 		rst,  	// Asynchronous reset active high
		input		start,
		input  [4:0]	i,
		output reg	ready,done,
		output [19:0]	f
	);

//	State Declaration
	localparam	[1:0]	IDLE	=	2'b00,
				OPERATE	=	2'b01,
				DONE 	=	2'b10;

//	Signal Declaration
	reg [1:0]	state_reg, state_next;
	reg [19:0]	t0_reg, t0_next, t1_reg, t1_next;
	reg [4:0]	n_reg, n_next;


//	FSM State and Data register
	always@(posedge clk or posedge rst)
		if(rst)
			begin
				state_reg	<=	IDLE;
				t0_reg		<=	0;
				t1_reg		<=	0;
				n_reg 		<=	0;
			end
		else
			begin
				state_reg 	<=	state_next;
				t0_reg 		<=	t0_next;
				t1_reg 		<=	t1_next;
				n_reg 		<=	n_next;
			end	


// 	Next State Logic
	always@(*)
		begin 
			state_next	=	state_reg;
			ready 		=	1'b0;
			done 		=	1'b0;
			t0_next 	=	t0_reg;
			t1_next 	=	t1_reg;
			n_next 		=	n_reg;

			case (state_reg)
				IDLE	:	begin
							ready		=	1'b1;
							if(start)
							  begin
							    t0_next	=	0;
							    t1_next	=	20'd1;
							    n_next 	=	i;
							    state_next	=	OPERATE;
							  end
							end

				OPERATE	:	if (n_reg == 0) 
							begin
						  	  t1_next	=	0;
							  state_next	=	DONE;	
							end
						else if(n_reg == 1)
						  	  state_next	=	DONE;
						else
							begin
							  t1_next 	=	t1_reg + t0_reg;
							  t0_next 	= 	t1_reg;
							  n_next	=	n_reg -	1;
							end

				DONE 	:	begin 
							  done 		=	1'b1;
							  state_next	=	IDLE;
						end

				default :	state_next 		=	IDLE;
			endcase
		end

//	Output
	assign	f 	=	t1_reg;

endmodule
