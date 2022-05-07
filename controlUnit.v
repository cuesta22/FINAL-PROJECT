module controlUnit(clk,rst,inst,stat_flag,ALU_OP,instruction_type,WB,ALUsrc,PCsrc,RW, MRW);

input clk,rst;
input [31:0] inst;
input [3:0] stat_flag;
output reg WB, ALUsrc, PCsrc,RW, MRW;
output reg [3:0] ALU_OP;
output reg [1:0] instruction_type;
	
always @(inst or rst)
	if(rst==0)
	case(inst[6:0])
	
		7'b0110011:begin //R-Type
		ALUsrc=1'b0;
		RW= 1'b1;
		MRW=1'b0;
		WB=1'b0;
		PCsrc=1'b0;
		instruction_type= 2'b00;
		ALU_OP={inst[30],inst[14:12]};
		end 
		
		7'b0010011:begin  //I-Type change accordingly
		ALUsrc=1'b1;
		RW= 1'b1;
		MRW=1'b0;
		WB=1'b1;
		PCsrc=1'b0;
		instruction_type= 2'b01;
		ALU_OP={inst[30],inst[14:12]};
		end 
		
		7'b0000011:begin //LW change accordingly
		ALUsrc=1'b1;
		RW= 1'b1;
		MRW=1'b0;
		WB=1'b1;
		PCsrc=1'b0;
		instruction_type= 2'b01;
		ALU_OP=4'b0000;
		end 
		
		7'b0100011:begin //S
		ALUsrc=1'b1;
		RW= 1'b1;
		MRW=1'b0;
		WB=1'b1;
		PCsrc=1'b0;
		instruction_type= 2'b10;
		ALU_OP=4'b0000;
		end 
		
		7'b1100011:begin //B
		ALUsrc=1'b0;
		RW=1'b0;
		MRW=1'b1;
		WB=1'b1;
		instruction_type=2'b11;
		ALU_OP=4'b1000;
		
		case (inst[14:12])
		3'b000:begin
		PCsrc=stat_flag[0]?1'b1:1'b0;
		end
		3'b100:begin 
		PCsrc=stat_flag[1]? 1'b1:1'b0;
		end 
		
		endcase
		end
		endcase
		else
		
		case(inst[6:0])
		7'b0000000:begin
		ALUsrc=1'b0;
		RW= 1'b0;
		MRW=1'b0;
		WB=1'b0;
		PCsrc=1'b0;
		instruction_type= 2'b00;
		ALU_OP=4'b0000;
		end
		endcase 
	endmodule 