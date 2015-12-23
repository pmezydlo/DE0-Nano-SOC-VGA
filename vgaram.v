module vgaram(
input clk50_in,
output reg hs_out,
output reg vs_out,
output wire [2:0] red_out,
output wire [1:0] green_out,
output wire [2:0] blue_out

);

reg clk25;
reg [9:0] horizontal_counter;
reg [9:0] vertical_counter;

reg [9:0] X;
reg [9:0] Y;

wire [7:0] red;
wire [7:0] green;
wire [7:0] blue;

assign red_out[2:0] = ((horizontal_counter >= 144) 
					&& (horizontal_counter < 784) 
					&& (vertical_counter >=39)
					&& (vertical_counter < 519)) ? red[7:5] : 3'b000; 
						
assign green_out[1:0] = ((horizontal_counter >= 144) 
					&& (horizontal_counter < 784) 
					&& (vertical_counter >=39)
					&& (vertical_counter < 519)) ? green[7:6] : 2'b00; 
					
assign blue_out[2:0] = ((horizontal_counter >= 144) 
					&& (horizontal_counter < 784) 
					&& (vertical_counter >=39)
					&& (vertical_counter < 519)) ? blue[7:5] : 3'b000; 
					
assign red =   ((horizontal_counter >= 144)&&(horizontal_counter < 344) ) ? 8'b11100000 : 8'b00000000;
assign green = ((horizontal_counter >= 344)&&(horizontal_counter < 544) ) ? 8'b11000000 : 8'b00000000;
assign blue =  ((horizontal_counter >= 544)&&(horizontal_counter < 784) ) ? 8'b11100000 : 8'b00000000;

always @(posedge clk50_in)
begin

 if (clk25 == 0)
 begin
      clk25 <= 1;
 end   
	 
	 else
	begin
	 clk25 <= 0;
    end

end


always @(posedge clk25)
begin
	
		if ((horizontal_counter > 0) && (horizontal_counter < 97))// -- 96+1
		begin	
			hs_out <= 0;
		end
		else
		begin
			hs_out <= 1;
		end 
		
		
		if ((vertical_counter > 0 ) && (vertical_counter < 3 )) //-- 2+1
		begin	
			vs_out <= 0;
		end		
		else
		begin
			vs_out <= 1;
		end
		
		horizontal_counter <= horizontal_counter+1;
    
		if (horizontal_counter == 800) 
		begin
			vertical_counter <= vertical_counter+1;
			horizontal_counter <= 0;
		end
    
		if (vertical_counter == 521)
		begin
			vertical_counter <= 0;
		end
		
end






endmodule