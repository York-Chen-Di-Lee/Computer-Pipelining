`define CYCLE_TIME 20
`define INSTRUCTION_NUMBERS 1401
`define INPUT 5
`timescale 1ns/1ps
`include "CPU.v"

module testbench;
reg Clk, Rst;
reg [31:0] cycles, i;

// Instruction DM initialilation
initial
begin
		
		cpu.IF.instruction[ 0] = 32'h030fc020; //add $t8,$t8,$t7	larger_next	
		cpu.IF.instruction[ 1] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 2] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 3] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 4] = 32'h000f7020; //add $t6,$zero,$t7 
		cpu.IF.instruction[ 5] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 6] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 7] = 32'b000000_00000_00000_00000_00000_100000;		

		cpu.IF.instruction[ 8] = 32'h00186020; //add $t4,$zero,$t8		larger_counti
		cpu.IF.instruction[ 9] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 10] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 11] = 32'b000000_00000_00000_00000_00000_100000;

		cpu.IF.instruction[ 12] = 32'h000e6820; //add $t5,$zero,$t6
		cpu.IF.instruction[ 13] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 14] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 15] = 32'b000000_00000_00000_00000_00000_100000;		
		
		cpu.IF.instruction[ 16] = 32'h08000038; //j   comp_larger
		cpu.IF.instruction[ 17] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 18] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 19] = 32'b000000_00000_00000_00000_00000_100000;

		cpu.IF.instruction[ 20] = 32'h000d5020; //add $t2,$zero,$t5 	larger_prime
		cpu.IF.instruction[ 21] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 22] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 23] = 32'b000000_00000_00000_00000_00000_100000;

		cpu.IF.instruction[ 24] = 32'h08000090; //j   two_or_not 
		cpu.IF.instruction[ 25] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 26] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 27] = 32'b000000_00000_00000_00000_00000_100000;

		cpu.IF.instruction[ 28] = 32'h012f4822; //sub $t1,$t1,$t7				smaller_next
		cpu.IF.instruction[ 29] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 30] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 31] = 32'b000000_00000_00000_00000_00000_100000;

		cpu.IF.instruction[ 32] = 32'h000f7020; //add $t6,$zero,$t7
		cpu.IF.instruction[ 33] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 34] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 35] = 32'b000000_00000_00000_00000_00000_100000;

		cpu.IF.instruction[ 36] = 32'h00096020; //add $t4,$zero,$t1				smaller_counti
		cpu.IF.instruction[ 37] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 38] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 39] = 32'b000000_00000_00000_00000_00000_100000;

		cpu.IF.instruction[ 40] = 32'h000e6820; //add $t5,$zero,$t6
		cpu.IF.instruction[ 41] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 42] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 43] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 44] = 32'h08000064; //j   comp_smaller
		cpu.IF.instruction[ 45] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 46] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 47] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 48] = 32'h000dc820; //add $t9,$zero,$t5  			smaller_prime
		cpu.IF.instruction[ 49] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 50] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 51] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 52] = 32'h080000a4; // j   output
		cpu.IF.instruction[ 53] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 54] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 55] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 56] = 32'h018d402a; //slt $t0,$t4,$t5	comp_larger
		cpu.IF.instruction[ 57] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 58] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 59] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 60] = 32'h1100000F; //beq $t0,$zero,subb_larger
		cpu.IF.instruction[ 61] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 62] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 63] = 32'b000000_00000_00000_00000_00000_100000;
				
		cpu.IF.instruction[ 64] = 32'h01805820; //add $t3,$t4,$zero
		cpu.IF.instruction[ 65] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 66] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 67] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 68] = 32'h01a06020; //add $t4,$t5,$zero
		cpu.IF.instruction[ 69] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 70] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 71] = 32'b000000_00000_00000_00000_00000_100000;

		cpu.IF.instruction[ 72] = 32'h01606820; //add $t5,$t3,$zero
		cpu.IF.instruction[ 73] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 74] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 75] = 32'b000000_00000_00000_00000_00000_100000;

		cpu.IF.instruction[ 76] = 32'h018d6022; //sub $t4,$t4,$t5	subb_larger
		cpu.IF.instruction[ 77] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 78] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 79] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 80] = 32'h1580ffe7; //bne $t4,$zero,comp_larger
		cpu.IF.instruction[ 81] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 82] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 83] = 32'b000000_00000_00000_00000_00000_100000;		
		
		cpu.IF.instruction[ 84] = 32'h130dffbf; //beq $t8,$t5,larger_prime  
		cpu.IF.instruction[ 85] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 86] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 87] = 32'b000000_00000_00000_00000_00000_100000;

		cpu.IF.instruction[ 88] = 32'h15afffa7; //bne $t5,$t7,larger_next
		cpu.IF.instruction[ 89] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 90] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 91] = 32'b000000_00000_00000_00000_00000_100000;

		cpu.IF.instruction[ 92] = 32'h01cf7020; //add $t6,$t6,$t7	
		cpu.IF.instruction[ 93] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 94] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 95] = 32'b000000_00000_00000_00000_00000_100000;

		cpu.IF.instruction[ 96] = 32'h08000008; //j   larger_counti
		cpu.IF.instruction[ 97] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 98] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 99] = 32'b000000_00000_00000_00000_00000_100000;

		cpu.IF.instruction[ 100] = 32'h018d402a; //slt $t0,$t4,$t5		comp_smaller
		cpu.IF.instruction[ 101] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 102] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 103] = 32'b000000_00000_00000_00000_00000_100000;

		cpu.IF.instruction[ 104] = 32'h1100000F; //beq $t0,$zero,subb_smaller
		cpu.IF.instruction[ 105] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 106] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 107] = 32'b000000_00000_00000_00000_00000_100000;

		cpu.IF.instruction[ 108] = 32'h01805820; //add $t3,$t4,$zero
		cpu.IF.instruction[ 109] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 110] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 111] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 112] = 32'h01a06020; //add $t4,$t5,$zero
		cpu.IF.instruction[ 113] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 114] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 115] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 116] = 32'h01606820; //add $t5,$t3,$zero
		cpu.IF.instruction[ 117] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 118] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 119] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 120] = 32'h018d6022; //sub $t4,$t4,$t5		subb_smaller
		cpu.IF.instruction[ 121] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 122] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 123] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 124] = 32'h1580ffe7; //bne $t4,$zero,comp_smaller
		cpu.IF.instruction[ 125] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 126] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 127] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 128] = 32'h112dffaf; //beq $t1,$t5,smaller_prime 
		cpu.IF.instruction[ 129] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 130] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 131] = 32'b000000_00000_00000_00000_00000_100000;
				
		cpu.IF.instruction[ 132] = 32'h15afff97; //bne $t5,$t7,smaller_next  
		cpu.IF.instruction[ 133] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 134] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 135] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 136] = 32'h01cf7020; //add $t6,$t6,$t7   
		cpu.IF.instruction[ 137] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 138] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 139] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 140] = 32'h08000024; //j   smaller_counti
		cpu.IF.instruction[ 141] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 142] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 143] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 144] = 32'h01ef5820; //add $t3,$t7,$t7					two_or_not
		cpu.IF.instruction[ 145] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 146] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 147] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 148] = 32'h112b0007; //beq $t1,$t3,output_two  
		cpu.IF.instruction[ 149] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 150] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 151] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 152] = 32'h0800001c; //j   smaller_next 
		cpu.IF.instruction[ 153] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 154] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 155] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 156] = 32'h000bc820; //add $t9,$zero,$t3				output_two
		cpu.IF.instruction[ 157] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 158] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 159] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 160] = 32'h080000a4; //	 j   output
		cpu.IF.instruction[ 161] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 162] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 163] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 164] = 32'b101011_00010_01010_00000_00000_000001; //sw $t2, 1($2) 
		cpu.IF.instruction[ 165] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 166] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 167] = 32'b000000_00000_00000_00000_00000_100000;
		
		cpu.IF.instruction[ 168] = 32'b101011_00010_11001_00000_00000_000010; //sw $t9, 2($2)
		cpu.IF.instruction[ 169] = 32'b000000_00000_00000_00000_00000_100000;	
		cpu.IF.instruction[ 170] = 32'b000000_00000_00000_00000_00000_100000;
		cpu.IF.instruction[ 171] = 32'b000000_00000_00000_00000_00000_100000;
		
		//for (i=96; i<128; i=i+1)  cpu.IF.instruction[ i] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.PC = 0;
		
		
	
end

// Data Memory & Register Files initialilation
initial
begin
	cpu.MEM.DM[0] = `INPUT;
	cpu.MEM.DM[1] = 32'd0;
	for (i=2; i<128; i=i+1) cpu.MEM.DM[i] = 32'b0;
	
	cpu.ID.REG[0] = 32'd0;
	cpu.ID.REG[1] = 32'd0;
	cpu.ID.REG[2] = 32'd0;
	cpu.ID.REG[3] = 32'd0;
	cpu.ID.REG[4] = 32'd0; 
	cpu.ID.REG[5] = 32'd0;
	cpu.ID.REG[6] = 32'd0; 
	cpu.ID.REG[7] = 32'd0; 
	cpu.ID.REG[8] = 32'd0;
	cpu.ID.REG[9] = `INPUT; 
	cpu.ID.REG[10] = 32'd0; 
	cpu.ID.REG[11] = 32'd0; 
	cpu.ID.REG[12] = 32'd0; 
	cpu.ID.REG[13] = 32'd0; 
	cpu.ID.REG[14] = 32'd0; 
	cpu.ID.REG[15] = 32'd1; 
	cpu.ID.REG[16] = 32'd0; 
	cpu.ID.REG[17] = 32'd0; 
	cpu.ID.REG[18] = 32'd0; 
	cpu.ID.REG[19] = 32'd0; 
	cpu.ID.REG[20] = 32'd0; 
	cpu.ID.REG[21] = 32'd0; 
	cpu.ID.REG[22] = 32'd0; 
	cpu.ID.REG[23] = 32'd0; 
	cpu.ID.REG[24] = `INPUT; 
	for (i=25; i<32; i=i+1) cpu.ID.REG[i] = 32'b0;
	
	


end

//clock cycle time is 20ns, inverse Clk value per 10ns
initial Clk = 1'b1;
always #(`CYCLE_TIME/2) Clk = ~Clk;

//Rst signal
initial begin
	cycles = 32'b0;
	Rst = 1'b1;
	#12 Rst = 1'b0;
end

CPU cpu(
	.clk(Clk),
	.rst(Rst)
);

//display all Register value and Data memory content
always @(posedge Clk) begin
	cycles <= cycles + 1;
	if (cpu.MEM.DM[2] != 32'd0 )begin
	    $display(" INPUT = %d", cpu.MEM.DM[0]);
		$display(" A     = %d", cpu.MEM.DM[2]);
		$display(" B     = %d", cpu.MEM.DM[1]);
	    $finish;
	end
	if (cycles == `INSTRUCTION_NUMBERS) $finish; // Finish when excute the 24-th instruction (End label).
	$display("PC: %d cycles: %d", cpu.FD_PC>>2 , cycles);	
	$display("  R00-R07: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[0], cpu.ID.REG[1], cpu.ID.REG[2], cpu.ID.REG[3],cpu.ID.REG[4], cpu.ID.REG[5], cpu.ID.REG[6], cpu.ID.REG[7]);
	$display("  R08-R15: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[8], cpu.ID.REG[9], cpu.ID.REG[10], cpu.ID.REG[11],cpu.ID.REG[12], cpu.ID.REG[13], cpu.ID.REG[14], cpu.ID.REG[15]);
	$display("  R16-R23: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[16], cpu.ID.REG[17], cpu.ID.REG[18], cpu.ID.REG[19],cpu.ID.REG[20], cpu.ID.REG[21], cpu.ID.REG[22], cpu.ID.REG[23]);
	$display("  R24-R31: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[24], cpu.ID.REG[25], cpu.ID.REG[26], cpu.ID.REG[27],cpu.ID.REG[28], cpu.ID.REG[29], cpu.ID.REG[30], cpu.ID.REG[31]);
	$display("  0x00   : %08x %08x %08x %08x %08x %08x %08x %08x", cpu.MEM.DM[0],cpu.MEM.DM[1],cpu.MEM.DM[2],cpu.MEM.DM[3],cpu.MEM.DM[4],cpu.MEM.DM[5],cpu.MEM.DM[6],cpu.MEM.DM[7]);
	$display("  0x08   : %08x %08x %08x %08x %08x %08x %08x %08x", cpu.MEM.DM[8],cpu.MEM.DM[9],cpu.MEM.DM[10],cpu.MEM.DM[11],cpu.MEM.DM[12],cpu.MEM.DM[13],cpu.MEM.DM[14],cpu.MEM.DM[15]);

end
//generate wave file, it can use gtkwave to display
initial begin
	$dumpfile("cpu_hw.vcd");
	$dumpvars;
end
endmodule

