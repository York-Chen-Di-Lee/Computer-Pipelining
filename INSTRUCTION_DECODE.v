`timescale 1ns/1ps

module INSTRUCTION_DECODE(
	clk,
	rst,
	PC,
	IR,
	MW_MemtoReg,
	MW_RegWrite,
	MW_RD,
	MDR,
	MW_ALUout,

	MemtoReg,
	RegWrite,
	MemRead,
	MemWrite,
	branch,
	jump,
	ALUctr,
	JT,
	DX_PC,
	NPC,
	A,
	B,
	imm,
	RD,
	MD,
);

input clk, rst, MW_MemtoReg, MW_RegWrite;
input [31:0] IR, PC, MDR, MW_ALUout;
input [4:0]  MW_RD;

output reg MemtoReg, RegWrite, MemRead, MemWrite, branch, jump;
output reg [2:0] ALUctr;
output reg [31:0]JT, DX_PC, NPC, A, B;
output reg [15:0]imm;
output reg [4:0] RD;
output reg [31:0] MD;

//register file
reg [31:0] REG [0:31];

always @(posedge clk or posedge rst)
	if(rst) begin
		A 	<=32'b0;
	end
	else if(MW_RegWrite)
		REG[MW_RD] <= (MW_MemtoReg)? MDR : MW_ALUout;

always @(posedge clk or posedge rst)
begin
	if(rst) begin //初始化
		A 	<=32'b0;		
		MD 	<=32'b0;
		imm <=16'b0;
	    DX_PC<=32'b0;
		NPC	<=32'b0;
		jump 	<=1'b0;
		JT 	<=32'b0;
	end else begin
		A 	<=REG[IR[25:21]]; // A 代表 rs register
		MD 	<=REG[IR[20:16]];
		imm <=IR[15:0];
	    DX_PC<=PC;
		NPC	<=PC;
		jump<=(IR[31:26]==6'd2)?1'b1:1'b0;
		JT	<={PC[31:28], IR[26:0], 2'b0};
		
	end
end

always @(posedge clk or posedge rst)
begin
   if(rst) begin
		B 		<= 32'b0;
		MemtoReg<= 1'b0;
		RegWrite<= 1'b0;
		MemRead <= 1'b0;
		MemWrite<= 1'b0;
		branch  <= 1'b0;
		ALUctr	<= 3'b0;
		RD 	<=5'b0;
		
   end else begin
   		case( IR[31:26] ) // IR[31:26] 決定要哪一種type  
		6'd0:
			begin  // R-type
				//因為RD已經被設定好了，所以不用設定Register Destination(RegDst)。
				B 	<= REG[IR[20:16]]; // B 代表 rt register
				RD 	<=IR[15:11]; // RD 代表 rd register 
				MemtoReg<= 1'b0; // R-type 寫回的資料不是從memory來的，因為直接跳過memory，所以是0
				RegWrite<= 1'b1; // 只要有寫回，就是1
				MemRead <= 1'b0; // 跳過memory，所以是0
				MemWrite<= 1'b0; // 跳過memory，所以是0
				branch  <= 1'b0; // 沒有跳位址，所以是0
			    case(IR[5:0]) // IR[5:0] = function
				    6'd32://add
				        ALUctr <= 3'd2;
					
					6'd34://sub
						ALUctr <= 3'd6;
						
					6'd36://and
						ALUctr <= 3'd0;
					
					6'd37://or
						ALUctr <= 3'd1;
					
					6'd42://slt
						ALUctr <= 3'd7;
					
		    	endcase
			end
		6'd35:  begin// lw   //寫之前先看該指令格式及訊號線哪些該打開哪些該關閉，input A在上述已經設定好了，那還需要設定什麼? for example:
			        //因為RD已經被設定好了，所以不用設定Register Destination(RegDst)。
					B<= { { 16{IR[15]} } , IR[15:0] }; //IR[15:0] 是 立即值(immediate)，16bit的有號數要擴展成32bit的有號數，後面的16bit都要是MSB的值，以利後面的ALU進行加減
					RD 	<=IR[20:16]; // 原本 R-type 的 rt resigster 變成 rd register，用來把值load出來，放到這個rd暫存器上
					MemtoReg<= 1'b1; // Load Word 的資料是從memory出來的，所以有經過memory，所以是1
					RegWrite<= 1'b1; // 只要有寫回，就是1
					MemRead <= 1'b1; // 他從memory裡面的地址所存的值讀出來、load出來，所以是1
					MemWrite<= 1'b0; // 沒有寫進去memory裡面，所以是0
					branch  <= 1'b0; // 沒有跳位址，所以是0
					ALUctr  <= 3'd2; // lw 和 sw 的ALU Control的代碼都是 010 (二進制) 或是 2 (十進制)
		 	end
		6'd43:  begin// sw  //其實做法都很雷同，確認好指令格式及訊號線即可
					//因為RD已經被設定好了，所以不用設定Register Destination(RegDst)。
					B<= { { 16{IR[15]} } , IR[15:0] }; //IR[15:0] 是 立即值(immediate)，16bit的有號數要擴展成32bit的有號數，後面的16bit都要是MSB的值，以利後面的ALU進行加減
					MemtoReg<= 1'b0; // 因為是把值存進去，沒有寫回Register，雖然有經過memory但是沒有回傳到register，所以是0
					RegWrite<= 1'b0; // 因為是把值存進去，沒有寫回Register，所以是0
					MemRead <= 1'b0; // 沒有從memory裡面讀值，所以是0
					MemWrite<= 1'b1; // 他把新的值寫進去data memory裡面的地址裡面，所以是1
					branch  <= 1'b0; // 沒有跳位址，所以是0
					ALUctr  <= 3'd2; // lw 和 sw 的ALU Control的代碼都是 010 (二進制) 或是 2 (十進制)
			    
		 	end
		6'd4:   begin // beq // 比較 A 和 B 誰相同 (比較 rs 和 rt 哪個相同)
		//如果兩者在ALU做相減 是 0 (zero)，
					B<= REG[IR[20:16]]; // B 代表 rt register
					MemtoReg<= 1'b0; // 因為沒有經過memory，所以是0
					RegWrite<= 1'b0; // 沒有寫回Register，所以是0
					MemRead <= 1'b0; // 沒有從memory裡面讀值，所以是0
					MemWrite<= 1'b0; // 沒有寫進去memory裡面，所以是0
					branch  <= 1'b1; // branch 一定要為1，這樣zero (1) 出來上去 和 branch (1) 進行 AND，出來才會是1(因為 1&1 = 1)，這樣才有辦法跳地址
					ALUctr  <= 3'd5; // (助教在exection.v裡面設定) beq的ALU Control的代碼是 101 (二進制) 或是 5 (十進制)
			end
		6'd5:   begin // bne
					B<= REG[IR[20:16]]; // B 代表 rt register
					MemtoReg<= 1'b0; // 因為沒有經過memory，所以是0
					RegWrite<= 1'b0; // 沒有寫回Register，所以是0
					MemRead <= 1'b0; // 沒有從memory裡面讀值，所以是0
					MemWrite<= 1'b0; // 沒有寫進去memory裡面，所以是0
					branch  <= 1'b1; // branch 一定要為1，這樣zero (1) 出來上去 和 branch (1) 進行 AND，出來才會是1(因為 1&1 = 1)，這樣才有辦法跳地址
					ALUctr  <= 3'd6; // (助教在exection.v裡面設定) beq的ALU Control的代碼是 110 (二進制) 或是 6 (十進制)
			end
		6'd2: begin  // j
					B<= 32'b0; //B 代表 rt register，因為不需要rs rt rd之類的register來儲值，所以乾脆設為0
					MemtoReg<= 1'b0; // 因為沒有經過memory，所以是0
					RegWrite<= 1'b0; // 沒有寫回Register，所以是0
					MemRead <= 1'b0; // 沒有從memory裡面讀值，所以是0
					MemWrite<= 1'b0; // 沒有寫進去memory裡面，所以是0
					branch  <= 1'b0; // Jump 和 branch 是兩碼事，所以branch是 0
					jump <= 1'b1; // 要jump 才要設為1
					JT <={PC[31:28], IR[25:0], 2'b0}; // IR[25:0] 是 立即值(immediate)，後面的2bit是用來做2 Left Shift，代表乘4。
					ALUctr  <= 3'd0; // 要讓 ALU code 有值，如果沒有值就會出來 
			end

			default: begin
				$display("ERROR instruction!!");
			end
		endcase
   end
end

endmodule